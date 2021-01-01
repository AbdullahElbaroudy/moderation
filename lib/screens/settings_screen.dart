import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:moderation_tool/blocs/initiate_loged_in_user.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/models/settings_model.dart';
import 'package:moderation_tool/models/user_model.dart';
import 'package:moderation_tool/utilites/prepare.dart';

class SettingsScreen extends StatefulWidget {
  static String id = 'SettingsScreen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool val = false;
  InitiateLogedInUserBloc _initiateLogedInUserBloc;
  bool onSession;
  Prepare _prepare;
  @override
  void initState() {
    _prepare = Prepare();
    onSession = false;
    _initiateLogedInUserBloc = InitiateLogedInUserBloc();
    super.initState();
  }

  @override
  void dispose() {
    _initiateLogedInUserBloc?.dispose();
    super.dispose();
  }

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  String dropdownValue = 'en';
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: _initiateLogedInUserBloc.scInitiateLogedInUserStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              if (!onSession) {
                isDark = snapshot.data.setting.isDark;
                currentColor =
                    Color(int.parse(snapshot.data.setting.favoriteColor));
                dropdownValue = snapshot.data.setting.lang;
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text(AppLocale.of(context).translat('setting')),
                ),
                body: Column(
                  children: [
                    ListTile(
                      title: Text('User'),
                      trailing: Column(
                        children: [
                          Text(AppLocale.of(context).translat('created_at')),
                          Text('${snapshot.data.createdAt}'),
                        ],
                      ),
                      subtitle: Text("${snapshot.data.userName}"),
                    ),
                    SizedBox(
                      height: _prepare.widgetUnits.screenHeight * 0.02,
                    ),
                    ListTile(
                      title: Text(AppLocale.of(context).translat('dark_mode')),
                      trailing: Switch(
                          value:
                              onSession ? isDark : snapshot.data.setting.isDark,
                          onChanged: (value) {
                            onSession = true;
                            setState(() {
                              isDark = value;
                            });
                          }),
                    ),
                    SizedBox(
                      height: _prepare.widgetUnits.screenHeight * 0.02,
                    ),
                    ListTile(
                      title: Text(
                          AppLocale.of(context).translat('favorite_color')),
                      trailing: RaisedButton(
                          child: Text(AppLocale.of(context).translat('pick')),
                          color: onSession
                              ? currentColor
                              : Color(int.parse(
                                  snapshot.data.setting.favoriteColor)),
                          onPressed: () {
                            _showColorDialog(
                                snapshot.data.setting.favoriteColor);
                          }),
                    ),
                    SizedBox(
                      height: _prepare.widgetUnits.screenHeight * 0.02,
                    ),
                    ListTile(
                      title: Text(AppLocale.of(context).translat('language')),
                      trailing: _dropDownMenue(snapshot.data.setting.lang),
                    ),
                    SizedBox(
                      height: _prepare.widgetUnits.screenHeight * 0.02,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: RaisedButton(
                            child: Text(AppLocale.of(context)
                                .translat('save_settings')),
                            onPressed: () async {
                              print(
                                  "on press  isDarkMode = ${isDark} & lang = ${dropdownValue} & color =0x${currentColor.value.toRadixString(16)}");
                              _initiateLogedInUserBloc.scUpdateSink.add(Setting(
                                  lang: dropdownValue,
                                  favoriteColor:
                                      '0x${currentColor.value.toRadixString(16)}',
                                  isDark: isDark));

                              Phoenix.rebirth(context);
                            })),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocale.of(context).translat('reset_setting'),
                        ),
                        GestureDetector(
                          onTap: () {
                            _initiateLogedInUserBloc.scUpdateSink
                                .add(Setting());
                            Phoenix.rebirth(context);
                          },
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(
                                  _prepare.widgetUnits.screenWidth * 0.01),
                              child: Text(
                                AppLocale.of(context).translat('reset'),
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(
                      height: _prepare.widgetUnits.screenHeight * 0.02,
                    ), ],
                ),
              );

              break;
            default:
              return CircularProgressIndicator();
              break;
          }
        });
  }

  _dropDownMenue(String snapLang) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      width: MediaQuery.of(context).size.width * 0.3,
      child: DropdownButton<String>(
        style: Theme.of(context).textTheme.body1,
        value: onSession ? dropdownValue : snapLang, // dropdownValue,
        icon: Icon(Icons.language),
        underline: Container(
          height: 1,
          color: Theme.of(context).accentColor,
        ),
        onChanged: (newValue) {
          onSession = true;
          print("new value = ${newValue}");
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: AppLocale.of(context)
            .supportedLanguges()
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(AppLocale.of(context).translat(value)),
          );
        }).toList(),
      ),
    );
  }

  _showColorDialog(String color) {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: onSession
                ? currentColor
                : Color(int.parse(color)), //currentColor,
            onColorChanged: (color) {
              print(
                  "onChanged color onChanged color ${color} == ${color.value.toRadixString(16)}");
              setState(() => pickerColor = color);
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.5,
            // pickerAreaBorderRadius: BorderRadius.all(Radius.circular(50)),
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(AppLocale.of(context).translat('pick')),
            onPressed: () {
              onSession = true;
              print(
                  "picker color ${pickerColor} && Current color ${currentColor}");
              setState(() {
                currentColor = pickerColor;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

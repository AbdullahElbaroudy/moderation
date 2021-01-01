import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moderation_tool/blocs/database_bloc.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/models/user_model.dart';
import 'package:moderation_tool/widgets/custom_profile_header_2.dart';
import 'package:moderation_tool/widgets/custom_text_field.dart';

class UserProfileScreen extends StatefulWidget {
  static String id = "UserProfileScreen";
  User user;
  int profileNow;
  UserProfileScreen({this.user, this.profileNow}) {
    this.profileNow = this.profileNow ?? 0;
  }
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameTextEditingController;
  TextEditingController _userNameTextEditingController;
  TextEditingController _phoneTextEditingController;
  TextEditingController _createdAtTextEditingController;
  TextEditingController _updatedAtTextEditingController;
  TextEditingController _birthDateTextEditingController;
  DataBaseBloc _dataBaseBloc;

  @override
  void initState() {
    _dataBaseBloc = DataBaseBloc();
    _nameTextEditingController = TextEditingController();
    _userNameTextEditingController = TextEditingController();
    _phoneTextEditingController = TextEditingController();
    _createdAtTextEditingController = TextEditingController();
    _updatedAtTextEditingController = TextEditingController();
    _birthDateTextEditingController = TextEditingController();
    print(
        "widget.user==null = ${widget.user == null}    widget.profile${widget.profileNow}");
    if (widget.user != null) {
      _dataBaseBloc.scSelectRowDBSink.add(User(id: widget.user.id));
    } else if (widget.profileNow != 0) {
      _dataBaseBloc.scSelectRowDBSink.add(User(id: widget.profileNow));
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameTextEditingController?.dispose();
    _userNameTextEditingController?.dispose();
    _phoneTextEditingController?.dispose();
    _createdAtTextEditingController?.dispose();
    _updatedAtTextEditingController?.dispose();
    _birthDateTextEditingController?.dispose();
    _dataBaseBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _dataBaseBloc.scTableDBStream,
          builder: (context, snapshot) {
            print("${snapshot.connectionState} ");
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                print("and snapshot = ${snapshot.data}");
                Map<String, dynamic> _usermap =
                    Map<String, dynamic>.from(snapshot.data.first);
                _nameTextEditingController.text = _usermap['name'];
                _userNameTextEditingController.text = _usermap['user_name'];
                _phoneTextEditingController.text = _usermap['phone_number'];
                _createdAtTextEditingController.text =
                    DateTime.fromMillisecondsSinceEpoch(_usermap['created_at'])
                        .toString();
                _updatedAtTextEditingController.text =
                    _usermap['updated_at'] == null
                        ? ''
                        : DateTime.fromMillisecondsSinceEpoch(
                                _usermap['updated_at'])
                            .toString();
                // DateTime birthDate = DateTime.parse(DateTime.fromMillisecondsSinceEpoch(_usermap['birth_date']).toString());
                _birthDateTextEditingController.text = _usermap['birth_date'] ==
                        null
                    ? ''
                    : '${DateTime.parse(DateTime.fromMillisecondsSinceEpoch(_usermap['birth_date']).toString()).day} - ${DateTime.parse(DateTime.fromMillisecondsSinceEpoch(_usermap['birth_date']).toString()).month} - ${DateTime.parse(DateTime.fromMillisecondsSinceEpoch(_usermap['birth_date']).toString()).year}';
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ImagePicker picker = ImagePicker();
                        PickedFile pickedFile = await picker.getImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          _usermap.update(
                              'picture', (value) => pickedFile.path);
                          _usermap.update('updated_at',
                              (value) => DateTime.now().millisecondsSinceEpoch);
                          _dataBaseBloc.scUpdateRowDBSink
                              .add(User.fromMap(_usermap));
                        } else {
                          print('No image selected.');
                        }
                      },
                      child: CustomProfileHeader2(
                        coverImage: _usermap['picture'] == null
                            ? null
                            : DecorationImage(
                                fit: BoxFit.fill,
                                colorFilter: ColorFilter.mode(
                                    Colors.grey, BlendMode.lighten),
                                image: FileImage(
                                  File(_usermap['picture']),
                                ),
                              ),
                        image: _usermap['picture'] == null
                            ? null
                            : DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(
                                  File(_usermap['picture']),
                                ),
                              ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1),
                          child: Form(
                            key: _formKey,
                            child: ListView(
                              children: [
                                CustomTextField(
                                  onFocusScopeChanged: (value) {
                                    if (!value) {
                                      if (_nameTextEditingController
                                              .text.length <
                                          51) {
                                        if (_usermap['name'] !=
                                            _nameTextEditingController.text) {
                                          _usermap.update(
                                              'name',
                                              (value) =>
                                                  _nameTextEditingController
                                                      .text);
                                          _usermap.update(
                                              'updated_at',
                                              (value) => DateTime.now()
                                                  .millisecondsSinceEpoch);
                                          _dataBaseBloc.scUpdateRowDBSink
                                              .add(User.fromMap(_usermap));
                                        }
                                      }
                                    }
                                  },
                                  textController: _nameTextEditingController,
                                  customEnableEditing: true,
                                  lableText:
                                      AppLocale.of(context).translat('name'),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                CustomTextField(
                                  textController:
                                      _userNameTextEditingController,
                                  enableReadOnly: true,
                                  lableText: AppLocale.of(context)
                                      .translat('user_name'),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                CustomTextField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(11),
                                      WhitelistingTextInputFormatter(
                                          RegExp("[0-9]")),
                                      FilteringTextInputFormatter.deny(
                                        RegExp(' '),
                                      ),
                                    ],
                                    textController: _phoneTextEditingController,
                                    onFocusScopeChanged: (value) {
                                      if (!value) {
                                        if (_phoneTextEditingController
                                                    .text.length ==
                                                11 ||
                                            _phoneTextEditingController
                                                    .text.length ==
                                                0) {
                                          if (_usermap['phone_number'] !=
                                              _phoneTextEditingController
                                                  .text) {
                                            _usermap.update(
                                                'phone_number',
                                                (value) =>
                                                    _phoneTextEditingController
                                                        .text);
                                            _usermap.update(
                                                'updated_at',
                                                (value) => DateTime.now()
                                                    .millisecondsSinceEpoch);
                                            _dataBaseBloc.scUpdateRowDBSink
                                                .add(User.fromMap(_usermap));
                                            _usermap.update(
                                                'phone_number',
                                                (value) =>
                                                    _phoneTextEditingController
                                                        .text);
                                            _usermap.update(
                                                'updated_at',
                                                (value) => DateTime.now()
                                                    .millisecondsSinceEpoch);
                                            _dataBaseBloc.scUpdateRowDBSink
                                                .add(User.fromMap(_usermap));
                                          }
                                        }
                                      }
                                    },
                                    customEnableEditing: true,
                                    lableText: AppLocale.of(context)
                                        .translat('phone_number')),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                CustomTextField(
                                  textController:
                                      _birthDateTextEditingController,
                                  enableReadOnly: true,
                                  lableText: AppLocale.of(context)
                                      .translat('birth_date'),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.date_range),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1980, 1, 1),
                                          maxTime: DateTime.now().subtract(
                                              Duration(days: 15 * 365)),
                                          onChanged: (date) {},
                                          onConfirm: (date) {
                                        _usermap.update(
                                            'birth_date',
                                            (value) =>
                                                date.millisecondsSinceEpoch);
                                        _usermap.update(
                                            'updated_at',
                                            (value) => DateTime.now()
                                                .millisecondsSinceEpoch);
                                        _dataBaseBloc.scUpdateRowDBSink
                                            .add(User.fromMap(_usermap));
                                      },
                                          currentTime: _usermap['birth_date'] ==
                                                  null
                                              ? DateTime.now()
                                              : DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          _usermap[
                                                              'birth_date']),
                                          locale: AppLocale.of(context)
                                              .langNowType(context));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                CustomTextField(
                                  textController:
                                      _updatedAtTextEditingController,
                                  enableReadOnly: true,
                                  lableText: AppLocale.of(context)
                                      .translat('updated_at'),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                CustomTextField(
                                  textController:
                                      _createdAtTextEditingController,
                                  enableReadOnly: true,
                                  lableText: AppLocale.of(context)
                                      .translat('created_at'),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                               
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
                break;
              case ConnectionState.waiting:
                return Container();
              default:
            }
          }),
    );
  }
}

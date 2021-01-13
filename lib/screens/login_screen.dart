import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/models/user_model.dart';
import 'package:moderation_tool/operations/sign_in.dart';
import 'package:moderation_tool/screens/registration_screen.dart';
import 'package:moderation_tool/utilites/prepare.dart';
import 'package:moderation_tool/widgets/custom_intro_header.dart';
import 'package:moderation_tool/widgets/custom_text_field.dart';
class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameTextEditingController;
  TextEditingController _passwordTextEditingController;
  FocusNode _focusNode2;
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _focusNode2 = FocusNode();
    _userNameTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode2?.dispose();
    _passwordTextEditingController?.dispose();
    _userNameTextEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color baseColor = Color(0xff10666D);
    Color highlightColor = Color(0xffF4EE3A);
    String word = 'TOOL';
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height * 0.3;
    double t = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          CustomIntroHeader(
              w: w,
              h: h,
              t: t,
              word: word,
              baseColor: baseColor,
              highlightColor: highlightColor),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      onTextSubmittedFunction: (value) {
                        _focusNode2.requestFocus();
                      },
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter(RegExp("[a-z 0-9]")),
                        FilteringTextInputFormatter.deny(
                          RegExp(' '),
                        ),
                      ],
                      animation: true,
                      textController: _userNameTextEditingController,
                      hintText:
                          AppLocale.of(context).translat('enter_user_name'),
                      lableText: AppLocale.of(context).translat('user_name'),
                      validatorFunction: (value) {
                        if (value.isEmpty) {
                          return AppLocale.of(context)
                              .translat('please_enter_user_name');
                        }
                      },
                      icon: Icons.supervised_user_circle,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    CustomTextField(
                      focusNode: _focusNode2,
                      textInputAction: TextInputAction.done,
                      onTextSubmittedFunction: (value) async {
                        await checkLogin();
                      },
                      enablePasswordText: true,
                      animation: true,
                      textController: _passwordTextEditingController,
                      hintText:
                          AppLocale.of(context).translat('enter_password'),
                      lableText: AppLocale.of(context).translat('password'),
                      validatorFunction: (value) {
                        if (value.isEmpty) {
                          return AppLocale.of(context)
                              .translat('please_enter_password');
                        }
                      },
                      icon: Icons.lock,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: RaisedButton(
                          child: Text(AppLocale.of(context).translat('login')),
                          onPressed: () async {
                            await checkLogin();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocale.of(context).translat('do_not_have_acount'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RegistrationScreen.id);
                          },
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.01),
                              child: Text(
                                AppLocale.of(context).translat('register_now'),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  checkLogin() async {
    User _user = await SignIn().signInWithUserNameAndPassword(
        _userNameTextEditingController.text,
        _passwordTextEditingController.text);
    if (_user.id != null) {
      Phoenix.rebirth(context);
    } else {
      _scaffoldKey.currentState.showSnackBar(    
        SnackBar(duration: Duration(seconds: 3),
          content: Text(AppLocale.of(context).translat('error_login'))),
      );
    }
  }
}
/*

 Column(
        children: [
          CustomIntroHeader(
              w: w,
              h: h,
              t: t,
              word: word,
              baseColor: baseColor,
              highlightColor: highlightColor),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.05),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: _prepare.widgetUnits.screenHeight * 0.07,
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      onTextSubmittedFunction: (value) {
                        print("%%%%%%%%%%%%%%%%%%%%%%Value = ${value}");
                        _focusNode2.requestFocus();
                      },
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter(RegExp("[a-z 0-9]")),
                        FilteringTextInputFormatter.deny(
                          RegExp(' '),
                        ),
                      ],
                      animation: true,
                      textController: _userNameTextEditingController,
                      hintText: AppLocale.of(context).translat('enter_user_name'),
                      lableText: AppLocale.of(context).translat('user_name'),
                      validatorFunction: (value) {
                        if (value.isEmpty) {
                          return AppLocale.of(context)
                              .translat('please_enter_user_name');
                        }
                      },
                      icon: Icons.supervised_user_circle,
                    ),
                    SizedBox(
                      height: _prepare.widgetUnits.screenHeight * 0.03,
                    ),
                    CustomTextField(
                      focusNode: _focusNode2,
                      textInputAction: TextInputAction.done,
                      onTextSubmittedFunction: (value) async {
                        await checkLogin();
                      },
                      enablePasswordText: true,
                      maxLines: 5,
                      animation: true,
                      textController: _passwordTextEditingController,
                      hintText: AppLocale.of(context).translat('enter_password'),
                      lableText: AppLocale.of(context).translat('password'),
                      validatorFunction: (value) {
                        if (value.isEmpty) {
                          return AppLocale.of(context)
                              .translat('please_enter_password');
                        }
                      },
                      icon: Icons.lock,
                    ),
                    SizedBox(
                      height: _prepare.widgetUnits.screenHeight * 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _prepare.widgetUnits.screenWidth * 0.2),
                      child: Container(
                        height: _prepare.widgetUnits.screenHeight * 0.09,
                        child: RaisedButton(
                          child: Text(AppLocale.of(context).translat('login')),
                          onPressed: () async {
                            await checkLogin();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _prepare.widgetUnits.screenHeight * 0.07,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocale.of(context).translat('do_not_have_acount'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RegistrationScreen.id);
                          },
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(
                                  _prepare.widgetUnits.screenWidth * 0.01),
                              child: Text(
                                AppLocale.of(context).translat('register_now'),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    

 */

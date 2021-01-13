
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moderation_tool/blocs/custom_text_field_bloc.dart';
import 'package:moderation_tool/blocs/initiate_loged_in_user.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/main.dart';
import 'package:moderation_tool/operations/sign_up.dart';
import 'package:moderation_tool/screens/login_screen.dart';
import 'package:moderation_tool/utilites/widget_unit.dart';
import 'package:moderation_tool/widgets/custom_intro_header.dart';
import 'package:moderation_tool/widgets/custom_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  
  TextEditingController _userNameTextEditingController;
  TextEditingController _passwordTextEditingController;
  TextEditingController _confirmPasswordTextEditingController;
  CustomTextFieldBloc _customTextFieldBloc;
  FocusNode _focusNode1;
  FocusNode _focusNode2;
  InitiateLogedInUserBloc _initiateLogedInUserBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _initiateLogedInUserBloc =InitiateLogedInUserBloc();
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _customTextFieldBloc = CustomTextFieldBloc();
    _userNameTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _initiateLogedInUserBloc.dispose();
    _focusNode1?.dispose();
    _focusNode2?.dispose();
    _customTextFieldBloc?.dispose();
    _userNameTextEditingController?.dispose();
    _passwordTextEditingController?.dispose();
    _confirmPasswordTextEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String word = 'TOOL';
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height * 0.3;
    double t = MediaQuery.of(context).textScaleFactor;
    Color baseColor = Color(0xff10666D);
    Color highlightColor = Color(0xffF4EE3A);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(

          key: _formKey,
          child: Column(
            children: [
              CustomIntroHeader(w: w, h: h, t: t, word: word, baseColor: baseColor, highlightColor: highlightColor),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: ListView(
                    children: [
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        onTextSubmittedFunction: (value) {
                          _focusNode1.requestFocus();
                        },
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter(RegExp("[a-z 0-9]")),
                          FilteringTextInputFormatter.deny(
                            RegExp(' '),
                          ),
                        ],
                        validatorFunction: (value) {
                          if (value.isEmpty) {
                            return AppLocale.of(context)
                                .translat('please_enter_user_name');
                          } else {}
                        },
                        animation: true,
                        textController: _userNameTextEditingController,
                        hintText:
                            AppLocale.of(context).translat('enter_user_name'),
                        lableText: AppLocale.of(context).translat('user_name'),
                        icon: Icons.supervised_user_circle,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        focusNode: _focusNode1,
                        onTextSubmittedFunction: (value) {
                          _focusNode2.requestFocus();
                        },
                        enablePasswordText: true,
                        animation: true,
                        textController: _passwordTextEditingController,
                        hintText:
                            AppLocale.of(context).translat('enter_password'),
                        lableText: AppLocale.of(context).translat('password'),
                        helperText:
                            AppLocale.of(context).translat('password_rules'),
                        validatorFunction: (value) {
                          if (value.isEmpty) {
                            return AppLocale.of(context)
                                .translat('please_enter_password');
                          } else {
                            String pattern =
                                r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$'; //  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
                            RegExp regExp = new RegExp(pattern);
                            if (regExp.hasMatch(value)) {
                            } else {
                              return AppLocale.of(context)
                                  .translat('password_rules');
                            }
                          }
                        },
                        icon: Icons.lock,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomTextField(
                        textInputAction: TextInputAction.done,
                        focusNode: _focusNode2,
                        onTextSubmittedFunction: (value) async {
                          await checkSignUp();
                        },
                        enablePasswordText: true,
                        animation: true,
                        textController: _confirmPasswordTextEditingController,
                        hintText: AppLocale.of(context)
                            .translat('enter_confirm_password'),
                        lableText:
                            AppLocale.of(context).translat('confirm_password'),
                        validatorFunction: (value) {
                          if (value.isEmpty) {
                            return AppLocale.of(context)
                                .translat("please_enter_password");
                          }
                          if (value == _passwordTextEditingController.text) {
                          } else {
                            return AppLocale.of(context)
                                .translat('dose_not_matched');
                          }
                        },
                        icon: Icons.lock,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.2),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          child: RaisedButton(
                            child:
                                Text(AppLocale.of(context).translat('sign_up')),
                            onPressed: () async {
                              await checkSignUp();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocale.of(context)
                                .translat('do_you_have_acount'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.id);
                            },
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.01),
                                child: Text(
                                  AppLocale.of(context).translat('login'),
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
            ],
          ),
        ),
      ),
    );
  }

  checkSignUp() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState.validate()) {
      SignUp()
          .signUpWithUserNameAndPassword(
              _userNameTextEditingController.text.toLowerCase().trim(),
              _confirmPasswordTextEditingController.text)
          .then((user) {
        if (user.id != null) {
          //_initiateLogedInUserBloc.scInitiateLogedInUserSink.add(user);
          Navigator.of(context).pushReplacementNamed(MyApp.id);
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("Registration Done ${_userNameTextEditingController.text} ^_^")),
          );
        } else {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
                content:
                    Text("Sorry ${_userNameTextEditingController.text}")),
          );
        }
      });
    }
  }

  
}


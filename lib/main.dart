/*
 Change userBloc constractor to singletone with 
StreamController<...> _controller = StreamController<...>.broadcast();
like this : https://stackoverflow.com/questions/51396769/flutter-bad-state-stream-has-already-been-listened-to
/////////////
make constractor of userBloc without singletone it will play well 
////////////////////////////
the real problem it wraping material app with stream builder throw that error 
you should search for this thing
i think its about Bloc 
see this 
https://www.raywenderlich.com/4074597-getting-started-with-the-bloc-pattern
https://www.didierboelens.com/2018/08/reactive-programming-streams-bloc/
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:moderation_tool/blocs/initiate_loged_in_user.dart';
import 'package:moderation_tool/database/database_helper.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/models/navigator_model.dart';
import 'package:moderation_tool/models/order_status_model.dart';
import 'package:moderation_tool/models/product_model.dart';
import 'package:moderation_tool/models/region_cost_model.dart';
import 'package:moderation_tool/models/settings_model.dart';
import 'package:moderation_tool/models/shipping_company_model.dart';
import 'package:moderation_tool/models/user_model.dart';
import 'package:moderation_tool/screens/add_product_screen.dart';
import 'package:moderation_tool/screens/home_screen.dart';
import 'package:moderation_tool/screens/login_screen.dart';
import 'package:moderation_tool/screens/permission_screen.dart';
import 'package:moderation_tool/screens/products_screen.dart';
import 'package:moderation_tool/screens/registration_screen.dart';
import 'package:moderation_tool/screens/settings_screen.dart';
import 'package:moderation_tool/screens/shipping_companies_screen.dart';
import 'package:moderation_tool/screens/shipping_companies_tabs/add_shipping_company_screen.dart';
import 'package:moderation_tool/screens/user_profile_screen.dart';
import 'package:moderation_tool/utilites/prepare.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  Prepare _prepare = Prepare();
  await _prepare.widgetUnits.initWindow();
  //runApp(Phoenix(child: DevicePreview(child: MyApp()))); 
  runApp(Phoenix(child: MyApp()));
}
class MyApp extends StatefulWidget {
  static String id = 'Main';
  @override  
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  MyDatabase database;
  User _user;
  Navigators _navigator;
  Setting _setting;
  Prepare _prepare;
  InitiateLogedInUserBloc _initiateLogedInUserBloc;
  @override
  void initState() {
    _prepare = Prepare();
    _initiateLogedInUserBloc=InitiateLogedInUserBloc();
    database=MyDatabase();
    _user=User();
    test();
    super.initState();
  }
  @override
  void dispose() {
    _initiateLogedInUserBloc?.dispose();
    super.dispose();
  }
  test() async {
   // await testAdmin();
  }
  testAdmin()async{
    _user = User(
        userName: 'admin', password: 'admin', setting: Setting(lang: 'en'));
    await database.insert(_user);
    _navigator = Navigators(
      navigationTitle: 'my_profile',
      status: true,
      userID: 1,
    );await database.insert(_navigator);
    _navigator = Navigators(
      navigationTitle: 'sign_out',
      status: true,
      userID: 1,
    );await database.insert(_navigator);
    _navigator = Navigators(
      navigationTitle: 'products',
      status: true,
      userID: 1,
    );await database.insert(_navigator);
    _navigator = Navigators(
      navigationTitle: 'shipping_company',
      status: true,
      userID: 1,
    );await database.insert(_navigator);
    _navigator = Navigators(
      navigationTitle: 'settings',
      status: true,
      userID: 1,
    );await database.insert(_navigator);
    _navigator = Navigators(
      navigationTitle: 'navigators',
      status: true,
      userID: 1,
    );await database.insert(_navigator);
    _navigator = Navigators(
      navigationTitle: 'orders',
      status: true,
      userID: 1,
    );await database.insert(_navigator);
  }  
  String word = 'TOOL';
  Color baseColor = Color(0xff10666D);
  Color highlightColor = Color(0xffF4EE3A);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        initialData: User(),
        stream: _initiateLogedInUserBloc.scInitiateLogedInUserStream,
        builder: (context, snapshot) {
          print("Snapshot of user = ${snapshot.connectionState}");
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return MaterialApp(
                //builder: DevicePreview.appBuilder,
                debugShowCheckedModeBanner: false,
                themeMode: buildThemeMood(snapshot.data.setting.isDark),
                darkTheme:buildDarkThemeData(snapshot.data.setting.favoriteColor),
                theme: buildLightThemeData(snapshot.data.setting.favoriteColor),
                // darkTheme: getTheme(context), //ThemeData.dark(),
                title:
                    '${snapshot.data.name ?? ''}Tool', //snapshot.data.name?? if null return '' %% if not null return its value
                locale: Locale(snapshot.data.setting.lang),
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  AppLocale.delegate,
                ],
                localeResolutionCallback:
                    (currentLocalLang, supportedLocalLangs) {
                  if (currentLocalLang != null) {
                    supportedLocalLangs.forEach((element) {
                      if (element.languageCode ==
                          currentLocalLang.languageCode) {
                        print("########lang of device ${currentLocalLang.languageCode}");
                        return currentLocalLang;
                      }
                    });
                  } else {
                    return supportedLocalLangs.first;
                  }
                },
                supportedLocales: [
                  Locale('ar', ''),
                  Locale('en', ''),
                ],
                initialRoute:
                      snapshot.data.id == null ? LoginScreen.id : HomeScreen.id,// AddProductsScreen.id,// /* PermissionScreen.id,*/snapshot.data.id == null ? LoginScreen.id : HomeScreen.id,
                routes:{
                  
                  HomeScreen.id: (context) => HomeScreen(),
                  MyApp.id: (context) => MyApp(),
                  LoginScreen.id: (context) => LoginScreen(),
                  RegistrationScreen.id: (context) => RegistrationScreen(),
                  SettingsScreen.id: (context) => SettingsScreen(),
                  PermissionScreen.id: (context) => PermissionScreen(),
                  UserProfileScreen.id:(context)=> UserProfileScreen(),
                  AddProductsScreen.id:(context)=> AddProductsScreen(),
                  ProductsScreen.id:(context)=> ProductsScreen(),
                  ShippingCompaniesScreen.id :(context)=> ShippingCompaniesScreen() ,
                  AddShippingCompanyScreen.id :(context)=> AddShippingCompanyScreen(),
                },
              );
              break;
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.done:
              return Container(color:Colors.white,child: Center(child: CircularProgressIndicator()));
              break;
            default:
          }
        });
  }
 ThemeMode buildThemeMood(bool isDark){
    if (isDark) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }
  ThemeData buildDarkThemeData(String favoriteColor) {
    Color color = Color(int.parse(favoriteColor));
    return ThemeData.dark().copyWith(
     accentColor: Colors.white,
     /*
      primaryColor: color,//app bar &border of textfield
      canvasColor: Colors.black,//color of body of drawer
      //focusColor: Colors.yellow,
      cursorColor: Colors.black,
      hintColor: Colors.yellow,
      hoverColor: Colors.red,
      indicatorColor: Colors.red,//color of indicator like in line under every tabs
      //cardColor: Colors.red,
      //backgroundColor: Colors.red,
      //highlightColor: Colors.red,
      //primaryColorDark: Colors.red,
      splashColor: Colors.white,//on long press color      
      selectedRowColor: Colors.red,
      textSelectionColor: Colors.black26, //color of selected text in textfield
      textSelectionHandleColor: Colors.black,*/ //when select text , 2 handeler appearance , this is a color of them
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.black,
        splashColor: Colors.white,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
        button: TextStyle(
          fontSize: _prepare.widgetUnits.screenWidth *
              0.05 *
              _prepare.checkLangscalability,
        ),
        body1: TextStyle(
          fontSize: _prepare.widgetUnits.screenWidth *
              0.045 *
              _prepare.checkLangscalability,
          color: Colors.white,//color of any text writed is screen you can get it from database later
        ),
        body2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: _prepare.widgetUnits.screenWidth *
              0.05 *
              _prepare.checkLangscalability,
          color: Colors.white,
        ),
      ),
    );
  }
  ThemeData buildLightThemeData(String favoriteColor) {
    Color color = Color(int.parse(favoriteColor));
    return ThemeData(
      accentColor: Colors.black,
      primaryColor: color, //app bar &border of textfield
      canvasColor: Colors.white,
      //focusColor: Colors.yellow,
      cursorColor: Colors.black,
      //hintColor: Colors.yellow,
      //hoverColor: Colors.red,
      //indicatorColor: Colors.red,
      //cardColor: Colors.red,
      textSelectionColor: Colors.black26, //color of selected text in textfield
      textSelectionHandleColor: Colors
          .black, //when select text , 2 handeler appearance , this is a color of them
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.black,
        splashColor: Colors.white,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
        button: TextStyle(
          fontSize: _prepare.widgetUnits.screenWidth *
              0.05 *
              _prepare.checkLangscalability,
        ),
        body1: TextStyle(
          fontSize: _prepare.widgetUnits.screenWidth *
              0.045 *
              _prepare.checkLangscalability,
          color: Colors.black,
        ),
        body2: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: _prepare.widgetUnits.screenWidth *
              0.05 *
              _prepare.checkLangscalability,
          color: color,
        ),
      ),
    );
  }
}

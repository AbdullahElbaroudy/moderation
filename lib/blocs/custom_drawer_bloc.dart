import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:moderation_tool/contract/disposable.dart';
import 'package:moderation_tool/models/navigator_model.dart';
import 'package:moderation_tool/models/user_model.dart';
import 'package:moderation_tool/operations/navigation_drawer.dart';
import 'package:moderation_tool/operations/sign_in.dart';
import 'package:moderation_tool/screens/permission_screen.dart';
import 'package:moderation_tool/screens/products_screen.dart';
import 'package:moderation_tool/screens/settings_screen.dart';
import 'package:moderation_tool/screens/shipping_companies_screen.dart';
import 'package:moderation_tool/screens/user_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CustomDrawerBloc implements Disposable {
  List<NavigationDrawer> navigators = [];
  

  final StreamController<List<NavigationDrawer>> _scCustomDrawer =
      StreamController<List<NavigationDrawer>>();

  StreamSink<List<NavigationDrawer>> get scCustomDrawerSink =>
      _scCustomDrawer.sink;
  Stream<List<NavigationDrawer>> get scCustomDrawerStream =>
      _scCustomDrawer.stream;

  prepareNavigators() async {
    SharedPreferences _sharedPrefrences = await SharedPreferences.getInstance();
    User _user = User(
      id:_sharedPrefrences.get('user_id'),
    );
    List<Navigators> userNavigatorsList = [];
    await _user.his(
        databaseModel: Navigators(),
        coulmnNames: ['status'],
        coulmnValues: [1.toString()]).then((mapList) {
      mapList.forEach((map) {
        userNavigatorsList.add(Navigators.fromMap(map));
      });
    });
    scCustomDrawerSink.add(drawList(userNavigatorsList));
  }

  CustomDrawerBloc() {
    print("from constractor of custom drawer bloc ");
    prepareNavigators();
  }

  List<NavigationDrawer> drawList(List<Navigators> userNavigators) {
    final List<NavigationDrawer> navigationDrawer = [

       NavigationDrawer(
        dbKey: 'my_profile',
        // screenId: ProfileScreen.id,
        keyTitle: 'my_profile',
        icon: Icons.account_circle,
        function: (context) {
          return () async {
            SharedPreferences _shared=await SharedPreferences.getInstance();
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return UserProfileScreen(profileNow: _shared.getInt('user_id'),);
            }));
          };
        },
      ),
      NavigationDrawer(
        dbKey: 'products',
        // screenId: ProfileScreen.id,
        keyTitle: 'products',
        icon: Icons.whatshot ,
        function: (context) {
          return () async {
            Navigator.of(context).pushNamed(ProductsScreen.id);
          };
        },
      ),
      NavigationDrawer(
        dbKey: 'orders',
        // screenId: ProfileScreen.id,
        keyTitle: 'orders',
        icon: Icons.account_circle,
        function: (context) {
          print(context.toString());
          return () async {};
        },
      ),
      NavigationDrawer(
          dbKey: 'shipping_company',
           keyTitle:'shipping_company',
          icon: Icons.local_shipping,
          function: (context) {
            return () async{
            Navigator.of(context).pushNamed(ShippingCompaniesScreen.id);    
            };
          }),  
      NavigationDrawer(
        dbKey: 'navigators',
        // screenId: ProfileScreen.id,
        keyTitle: 'navigator_permission',
        icon: Icons.settings_power,
        function: (context) {
          print(context.toString());
          return () async {
            Navigator.of(context).pushNamed(PermissionScreen.id);
          };
        },
      ),  
      NavigationDrawer(
        dbKey: 'settings',
        //  screenId: ProfileScreen.id,
        keyTitle: 'setting',
        icon: Icons.settings,
        function: (context) {
          print(context.toString());
          return () async {
            Navigator.of(context).pushNamed(SettingsScreen.id);
          };
        },
      ),
      NavigationDrawer(
        dbKey: 'sign_out',
        keyTitle: 'sign_out',
        icon: Icons.exit_to_app,
        function: (BuildContext context) {
          return () async {
          bool _done = await SignIn().exitUser();
          Phoenix.rebirth(context);
          // Navigator.of(context).pushReplacementNamed(LoginScreen.id);
          };
        },
      ),
    ];

    List<NavigationDrawer> userNavigationDrawer = [];

    navigationDrawer.forEach((drawerElement) {
      userNavigators.forEach((navigator) {
        if (navigator.navigationTitle == drawerElement.dbKey)
          userNavigationDrawer.add(drawerElement);
      });
    });

    return userNavigationDrawer;
  }

  @override
  dispose() {
    _scCustomDrawer.close();
  }
}

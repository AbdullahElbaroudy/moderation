import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/screens/permission_tabs/order_status.dart';
import 'package:moderation_tool/screens/permission_tabs/users_navigators_tab.dart';
import 'package:moderation_tool/screens/permission_tabs/users_tab.dart';

class PermissionScreen extends StatefulWidget {
  static String id = 'PermissionScreen';
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocale.of(context).translat('permission')),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.account_box)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: TabBarView(
          dragStartBehavior: DragStartBehavior.start,
          children: [
            UsersTab(),
            UsersNavigatorsTab(),
            OrderStatusTab(),
          ],
        ),
      ),
    );
  }
}

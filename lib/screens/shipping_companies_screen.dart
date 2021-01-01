

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/screens/permission_tabs/order_status.dart';
import 'package:moderation_tool/screens/permission_tabs/users_navigators_tab.dart';
import 'package:moderation_tool/screens/permission_tabs/users_tab.dart';
import 'package:moderation_tool/screens/shipping_companies_tabs/region_cost_tab.dart';
import 'package:moderation_tool/screens/shipping_companies_tabs/shiping_company_tab.dart';

class ShippingCompaniesScreen extends StatefulWidget {
  static String id = 'ShippingCompaniesScreen';
  @override
  _ShippingCompaniesScreenState createState() => _ShippingCompaniesScreenState();
}

class _ShippingCompaniesScreenState extends State<ShippingCompaniesScreen> {

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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocale.of(context).translat('shipping_company')),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.local_shipping)),
              Tab(icon: Icon(Icons.location_city)),
            ],
          ),
        ),
        body: TabBarView(
          dragStartBehavior: DragStartBehavior.start,
          children: [
            ShippingTab(),
            RegionCostTab(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moderation_tool/screens/add_product_screen.dart';

class OrderStatusTab extends StatefulWidget {

  @override
  _OrderStatusTabState createState() => _OrderStatusTabState();
}

class _OrderStatusTabState extends State<OrderStatusTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(

          onPressed: () {
          Navigator.of(context).pushNamed(AddProductsScreen.id);
        },

        child: Icon(Icons.add),
      ),
    );
  }
}

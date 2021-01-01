import 'package:flutter/material.dart';

typedef ManyOperation(int firstNo , int secondNo); 

class NavigationDrawer{
  String dbKey ;
  String keyTitle ;
  String screenId ;
  IconData icon;
  Widget widget;
  String keySubTitle;
  String description;
  
 Function() Function(BuildContext context) function;  

 
 NavigationDrawer({this.dbKey,this.keyTitle, this.screenId,this.description,this.icon,this.keySubTitle,this.widget,this.function});


}
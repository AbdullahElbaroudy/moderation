import 'package:flutter/material.dart';
import 'package:moderation_tool/blocs/custom_drawer_bloc.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/operations/navigation_drawer.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  CustomDrawerBloc _customDrawerBloc;
  @override
  void initState() {
    _customDrawerBloc = CustomDrawerBloc();
    super.initState();
  }

  @override
  void dispose() {
    _customDrawerBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NavigationDrawer>>(
            stream: _customDrawerBloc.scCustomDrawerStream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  return Drawer(
                      child: ListView.builder(
                    itemCount: snapshot.data.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return UserAccountsDrawerHeader(
                            accountName: Text(""), accountEmail: Text(''));
                      }
                      return ListTile(
                        title: Text(AppLocale.of(context)
                            .translat(snapshot.data[index - 1].keyTitle)),
                        leading: Icon(snapshot.data[index - 1].icon),
                        onTap: snapshot.data[index - 1].function(context),
                      );
                    },
                  ));
                  break;
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.done:
                return Center(
                  child: Center(child: CircularProgressIndicator())
                );
                  break;
                default:
              }
            });
     
  }
}

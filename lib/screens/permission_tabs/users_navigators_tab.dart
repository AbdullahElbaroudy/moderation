
import 'package:flutter/material.dart';
import 'package:moderation_tool/blocs/database_bloc.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/models/navigator_model.dart';
import 'package:moderation_tool/models/user_model.dart';
class UsersNavigatorsTab extends StatefulWidget {
  @override
  _UsersNavigatorsTabState createState() => _UsersNavigatorsTabState();
}

class _UsersNavigatorsTabState extends State<UsersNavigatorsTab> {
  DataBaseBloc _dataBaseBloc;
  @override
  void initState() {
    _dataBaseBloc = DataBaseBloc();
    _dataBaseBloc.scSelectTableWithOutModelNowDBSink.add(User());
    super.initState();
  }

  @override
  void dispose() {
    _dataBaseBloc.dispose();
    super.dispose();
  }

  bool isFirst = false;
  List<Map<String, dynamic>> maps = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _dataBaseBloc.scTableDBStream,
      builder: (context, snapshot) {
        print("${snapshot.connectionState}");
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            if (isFirst) {
              //after first opinig fetch this lines

              snapshot.data.forEach((mapRead) {
                Map<String, dynamic> map = Map<String, dynamic>.from(
                    mapRead); // to cast  Map<String, dynamic>.from(mapRead)
                map.addAll({"isExpanded": false});
                maps.add(map);
              });
              isFirst = false;
            }

            return ListView(children: [
              ExpansionPanelList(
                expansionCallback: (index, isExpanded) {
                  setState(() {
                    maps[index].update(
                        'isExpanded', (value) => !maps[index]['isExpanded']);
                  });
                },
                children: maps.map((user) {
                  User _user = User.fromMap(user);
                  return ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: ListTile(
                            selectedTileColor: Colors.red,
                            title: Text(_user.userName),
                          ),
                        ),
                      );
                    },
                    isExpanded: user['isExpanded'],
                    body: ExpantionListBody(_user),
                  );
                }).toList(),
              ),
            ]);
            break;
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.done:
            isFirst = true;
            print(" isFirst from waiting = ${isFirst}");
            return CircularProgressIndicator();
            break;
          default:
        }
      },
    );
  }
}

class ExpantionListBody extends StatefulWidget {
  User _user;
  ExpantionListBody(this._user);
  @override
  _ExpantionListBodyState createState() => _ExpantionListBodyState();
}

class _ExpantionListBodyState extends State<ExpantionListBody> {
  DataBaseBloc _dataBaseBloc;
 
  @override
  void initState() {
    _dataBaseBloc = DataBaseBloc();
    _dataBaseBloc.scSelectTableDBSink.add(Navigators(userID: widget._user.id));
    super.initState();
  }

  @override
  void dispose() {
    _dataBaseBloc?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _dataBaseBloc.scTableDBStream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            List<Map<String, dynamic>> maps = snapshot.data
                .where((navigator) => navigator['user_id'] == widget._user.id)
                .toList();
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Column(
                    children: maps.map(
                      (mapNavigator) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.05),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocale.of(context).translat('${mapNavigator['navigation_title']}')),
                                Switch(
                                  value: mapNavigator['status'] == 1,
                                  onChanged: (value) {
                                    Map<String, dynamic> map =
                                        Map<String, dynamic>.from(mapNavigator);
                                    map.update('status', (x) => value ? 1 : 0);
                                    print(" after switching  ${map}");
                                    _dataBaseBloc.scUpdateReturnTableDBSink
                                        .add(Navigators.fromMap(map));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            );
            break;
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          default:
        }
      },
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _dataBaseBloc.scTableDBStream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            List<Map<String, dynamic>> maps = snapshot.data
                .where((navigator) => navigator['user_id'] == widget._user.id)
                .toList();
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Column(
                    children: maps.map(
                      (mapNavigator) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.05),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocale.of(context).translat('${mapNavigator['navigation_title']}')),
                                Switch(
                                  value: mapNavigator['status'] == 1,
                                  onChanged: (value) {
                                    Map<String, dynamic> map =
                                        Map<String, dynamic>.from(mapNavigator);
                                    map.update('status', (x) => value ? 1 : 0);
                                    print(" after switching  ${map}");
                                    _dataBaseBloc.scUpdateRowDBSink
                                        .add(Navigators.fromMap(map));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            );
            break;
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          default:
        }
      },
    );
  }*/
}
/*
class SetNavigatorsPermision extends StatefulWidget {
  List<Map<String, dynamic>> maps;
  SetNavigatorsPermision(this.maps);
  @override
  _SetNavigatorsPermisionState createState() => _SetNavigatorsPermisionState();
}

class _SetNavigatorsPermisionState extends State<SetNavigatorsPermision> {
  DataBaseBloc _dataBaseBloc;
  @override
  void initState() {
    _dataBaseBloc = DataBaseBloc();
    super.initState();
  }

  @override
  void dispose() {
    _dataBaseBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.maps.map((mapNavigator) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(mapNavigator['navigation_title']),
              Switch(
                  value: mapNavigator['status'] == 1,
                  onChanged: (value) {
                    Map<String, dynamic> map =
                        Map<String, dynamic>.from(mapNavigator);
                    map.update('status', (x) => value ? 1 : 0);
                    print(" after switching  ${map}");
                    setState(() {
                      _dataBaseBloc.scUpdateRowDBSink
                          .add(Navigators.fromMap(map));
                    });
                  })
            ],
          ),
        );
      }).toList(),
    );
  }
}
*/

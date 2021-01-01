import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moderation_tool/blocs/database_bloc.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/models/user_model.dart';
import 'package:moderation_tool/screens/user_profile_screen.dart';
import 'package:moderation_tool/widgets/Custom_user_details_card.dart';
class UsersTab extends StatefulWidget {
  const UsersTab({
    Key key,
  }) : super(key: key);

  @override
  _UsersTabState createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  DataBaseBloc _dataBaseBloc;
  @override
  void initState() {
    _dataBaseBloc = DataBaseBloc();
    _dataBaseBloc.scSelectTableDBSink.add(User());
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
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  User _user = User.fromMap(snapshot.data[index]);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return UserProfileScreen(
                          user: _user,
                        );
                      }));
                    },
                    child: UserDetailsCard(
                      image: (_user.picture==null)?null:DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(File(_user.picture))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocale.of(context).translat('name')),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.02,
                                  ),
                                  Flexible(child: Text(_user.name ?? '')),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocale.of(context)
                                      .translat('phone_number')),
                                  SizedBox(
                                    width:MediaQuery.of(context).size.width * 0.03,
                                  ),
                                  Flexible(child: Text(_user.phoneNumber ?? '')),
                                   SizedBox(
                                    width:MediaQuery.of(context).size.width * 0.02,
                                  ),
                                ]),
                                 Row(children: [
                              Text(AppLocale.of(context).translat('birth_date')),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Flexible(
                                  child: Text(
                                _user.birthDate==null?'':"${_user.birthDate.day} - ${_user.birthDate.month} - ${_user.birthDate.year}",
                              )),
                            ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocale.of(context)
                                      .translat('created_at')),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.03,
                                  ),
                                  Flexible(
                                      child: Text(
                                    _user.createdAt.toString() ?? '',
                                  )),
                                ]),
                           
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
              break;
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.done:
              return Center(child: CircularProgressIndicator());
              break;
            default:
          }
        });
  }
}

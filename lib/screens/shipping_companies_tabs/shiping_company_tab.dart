import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moderation_tool/blocs/database_bloc.dart';
import 'package:moderation_tool/contract/database_model.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/models/shipping_company_model.dart';
import 'package:moderation_tool/screens/shipping_companies_tabs/add_shipping_company_screen.dart';

class ShippingTab extends StatefulWidget {
  @override
  _ShippingTabState createState() => _ShippingTabState();
}

class _ShippingTabState extends State<ShippingTab> {
  DataBaseBloc _dataBaseBloc ;
  ShippingCompany _shippingCompany;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _dataBaseBloc =DataBaseBloc();
    _dataBaseBloc.scSelectTableDBSink.add(ShippingCompany());
    super.initState();
  }
  @override
  void dispose() {
    _dataBaseBloc?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()async{
          await Navigator.of(context)
              .push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) {
                return AddShippingCompanyScreen();
              },
            ),
          ).then((value) {
            value =value??false;
           if(value) _dataBaseBloc.scSelectTableDBSink.add(ShippingCompany());
          });
        },
      ),
          body: StreamBuilder<List<Map<String, dynamic>>>(
        builder: (context,snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.active:
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                  _shippingCompany = ShippingCompany.fromMap(snapshot.data[index]);
                    return  Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.22,
                                child: Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    onTap: () async {},
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.indigoAccent,
                                      child: Text(''),
                                      foregroundColor: Colors.white,
                                    ),
                                    title: Text(''),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                      
                                      ],
                                    ),
                                  ),
                                ),
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Delete',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () async {
                                    
                                    },
                                  ),
                                  IconSlideAction(
                                    caption: 'edit',
                                    color: Colors.blue.shade200,
                                    icon: Icons.edit,
                                    onTap: () async {
                                      await Navigator.of(context)
                                          .push(
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) {
                                            
                                          },
                                        ),
                                      ).then(
                                        (value) {
                                            value =value??false;
                                            
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ); 
                  },
                );
              break;
               case ConnectionState.none:
                 return Center(
                   child: Text(AppLocale.of(context).translat('data_empty')),
                 );
               break;
            case ConnectionState.waiting:
            case ConnectionState.done:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            default:
          }
        },
      ),
    );
  }
}
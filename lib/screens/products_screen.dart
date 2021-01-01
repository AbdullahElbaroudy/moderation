import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moderation_tool/blocs/database_bloc.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/models/product_model.dart';
import 'package:moderation_tool/screens/add_product_screen.dart';
import 'package:moderation_tool/widgets/custom_text_field.dart';

class ProductsScreen extends StatefulWidget {
  static String id = 'ProductsScreen';
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  DataBaseBloc _dataBaseBloc;
  Products _products;
  TextEditingController _searchTextEditingController;
  @override
  void initState() {
    _dataBaseBloc = DataBaseBloc();
    _dataBaseBloc.scSelectTableDBSink.add(Products());
    _searchTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    _dataBaseBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocale.of(context).translat('products'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) {
                return AddProductsScreen();
              },
            ),
          ).then((value) {
            value =value??false;
           if(value) _dataBaseBloc.scSelectTableDBSink.add(Products());
          });
        },
        child: Icon(Icons.add),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: _dataBaseBloc.scTableDBStream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return searchField();
                        } else {
                          _products =
                              Products.fromMap(snapshot.data[index - 1]);
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.01),
                            child: Slidable(
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.22,
                              child: Container(
                                color: Colors.white,
                                child: ListTile(
                                  onTap: () async {},
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.indigoAccent,
                                    child: Text("${_products.vailableNumber}"),
                                    foregroundColor: Colors.white,
                                  ),
                                  title: Text('${_products.name}'),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${_products.type}'),
                                      Text('${_products.color}'),
                                      Text('${_products.cost}'),
                                      Text('${_products.cost*_products.vailableNumber}'),
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
                                    _dataBaseBloc.scDeleteRowReturnTableDBSink
                                        .add(_products);
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
                                          return AddProductsScreen(
                                            product: _products,
                                          );
                                        },
                                      ),
                                    ).then(
                                      (value) {
                                          value =value??false;
                                          if(value) _dataBaseBloc.scSelectTableDBSink.add(Products());
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  );
                  break;
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
              }
            }),
      ),
    );
  }

  Widget searchField() {
    return CustomTextField(
      textController: _searchTextEditingController,
      hintText: 'search here',
      onChangedFunction: (value) {
        print(value);
      },
    );
  }
}

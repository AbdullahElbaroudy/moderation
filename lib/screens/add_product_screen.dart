import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moderation_tool/blocs/database_bloc.dart';
import 'package:moderation_tool/locale/app_locale.dart';
import 'package:moderation_tool/models/product_model.dart';
import 'package:moderation_tool/screens/products_screen.dart';
import 'package:moderation_tool/widgets/custom_text_field.dart';

class AddProductsScreen extends StatefulWidget {
  
  Products product ;
  AddProductsScreen({this.product});

  static String id = "AddProductsScreen";
  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen>{
  DataBaseBloc _dataBaseBloc;
   FocusNode _focusNode1;
  FocusNode _focusNode2;
   FocusNode _focusNode3;
  FocusNode _focusNode4;
  TextEditingController _nameTextEditingController;
  TextEditingController _typeTextEditingController;
  TextEditingController _colorTextEditingController;
  TextEditingController _costTextEditingController;
  TextEditingController _availableNumberTextEditingController;
  TextEditingController _imagTextEditingController;


  @override
  void initState() {
     _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
     _focusNode3 = FocusNode();
    _focusNode4 = FocusNode();
    _dataBaseBloc =DataBaseBloc();
    _nameTextEditingController = TextEditingController();
    _typeTextEditingController = TextEditingController();
    _colorTextEditingController = TextEditingController();
    _costTextEditingController = TextEditingController();
    _availableNumberTextEditingController = TextEditingController();
    _imagTextEditingController = TextEditingController();
    if (widget.product !=null) {
    _nameTextEditingController.text = widget.product.name;
    _typeTextEditingController.text = widget.product.type;
    _colorTextEditingController.text = widget.product.color;
    _costTextEditingController.text = widget.product.cost.toString();
    _availableNumberTextEditingController.text = widget.product.vailableNumber.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    _focusNode1?.dispose();
    _focusNode2?.dispose();
    _focusNode3?.dispose();
    _focusNode4?.dispose();
    _dataBaseBloc?.dispose();
    _nameTextEditingController?.dispose();
    _typeTextEditingController?.dispose();
    _colorTextEditingController?.dispose();
    _costTextEditingController?.dispose();
    _availableNumberTextEditingController?.dispose();
    _imagTextEditingController?.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
      title: Text(AppLocale.of(context).translat('add_product')),
      ),
      body: StreamBuilder(
        stream: _dataBaseBloc.scRowDBStream,
        builder: (context, snapshot) {
          return Stack(
           children: [
             Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.08),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomTextField(
                    onTextSubmittedFunction: (value) {
                          _focusNode1.requestFocus();
                        },
                    textController: _nameTextEditingController,
                    lableText: AppLocale.of(context).translat('name'),
                    textInputAction: TextInputAction.next,
                    validatorFunction: (value){
                      if(value.isEmpty)return AppLocale.of(context).translat('dont_empty_field');
                    },
                  ),
                   SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  CustomTextField(
                    focusNode: _focusNode1,
                    onTextSubmittedFunction: (value) {
                          _focusNode2.requestFocus();
                        },
                    textInputAction: TextInputAction.next,
                    textController: _typeTextEditingController,
                    lableText: AppLocale.of(context).translat('type'),
                    validatorFunction: (value){
                      if(value.isEmpty)return AppLocale.of(context).translat('dont_empty_field');
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  CustomTextField(
                    focusNode: _focusNode2,
                    onTextSubmittedFunction: (value) async{
                          _focusNode3.requestFocus();
                        },
                    textInputAction: TextInputAction.next,
                    textController: _colorTextEditingController,
                    lableText: AppLocale.of(context).translat('color'),
                    validatorFunction: (value){
                      if(value.isEmpty)return AppLocale.of(context).translat('dont_empty_field');
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  CustomTextField(
                    focusNode: _focusNode3,
                    onTextSubmittedFunction: (value) async{
                          _focusNode4.requestFocus();
                        },
                    textInputAction: TextInputAction.next,
                    textController: _costTextEditingController,
                    lableText: AppLocale.of(context).translat('cost'),
                    textInputType: TextInputType.number,
                    validatorFunction: (value){
                      if(value.isEmpty)return AppLocale.of(context).translat('dont_empty_field');
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  CustomTextField(
                    focusNode: _focusNode4,
                    textController: _availableNumberTextEditingController,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
                    ],
                    lableText: AppLocale.of(context).translat('available_number'),
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onTextSubmittedFunction: (value)async{
                     await save();
                    },
                    validatorFunction: (value){
                      if(value.isEmpty)return AppLocale.of(context).translat('dont_empty_field');
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                ],
              ),
            ),
          ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(width: MediaQuery.of(context).size.width*0.4,child: RaisedButton(onPressed: ()async{
               await save();
              },child: widget.product==null?Text(AppLocale.of(context).translat('save')):Text(AppLocale.of(context).translat('update')),))),
           ], 
          );
        }
      ));
    
  }
  save()async{
     if (_formKey.currentState.validate()) {
                  Products _products = Products(
                    color: _colorTextEditingController.text,
                    cost: double.parse(_costTextEditingController.text),
                    type: _typeTextEditingController.text,
                    name: _nameTextEditingController.text,
                    vailableNumber: int.parse(_availableNumberTextEditingController.text),
                  );
                  if (widget.product ==null) {
                  _dataBaseBloc.scInsertRowDBSink.add(_products);
                  Navigator.of(context).pop(true);
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text("${AppLocale.of(context).translat('adding_finished')} ${_products.name}  ${_products.type}"))
                  ); 
                  }else{
                    Map<String,dynamic> map = _products.toMap();
                    map.update('id', (value) => widget.product.id);
                    _dataBaseBloc.scUpdateReturnTableDBSink.add(Products.fromMap(map)); 
                    Navigator.of(context).pop(true);
                   // Navigator.pushReplacementNamed(context,ProductsScreen.id,);
                  }
                  }
  }
}

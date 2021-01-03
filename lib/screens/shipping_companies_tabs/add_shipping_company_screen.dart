import 'package:flutter/material.dart';
import 'package:moderation_tool/blocs/database_bloc.dart';
import 'package:moderation_tool/models/shipping_company_model.dart';

class AddShippingCompanyScreen extends StatefulWidget {
  static String id = 'AddShippingCompanyScreen';
  ShippingCompany shippingCompany ;
  AddShippingCompanyScreen({this.shippingCompany});
  @override
  _AddShippingCompanyScreenState createState() => _AddShippingCompanyScreenState();
}

class _AddShippingCompanyScreenState extends State<AddShippingCompanyScreen> {
  DataBaseBloc _dataBaseBloc;
   FocusNode _focusNode1;
  FocusNode _focusNode2;
   FocusNode _focusNode3;
  FocusNode _focusNode4;
  TextEditingController _nameTextEditingController;
  TextEditingController _addressTextEditingController;
  TextEditingController _notesTextEditingController;
  TextEditingController _phoneNumber1TextEditingController;
  TextEditingController _phoneNumber2TextEditingController;
  
  ShippingCompany _shippingCompany =ShippingCompany();
  @override
  void initState() {
     _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
     _focusNode3 = FocusNode();
    _focusNode4 = FocusNode();
    _dataBaseBloc =DataBaseBloc();
    _nameTextEditingController = TextEditingController();
    _addressTextEditingController = TextEditingController();
    _notesTextEditingController = TextEditingController();
    _phoneNumber1TextEditingController = TextEditingController();
    _phoneNumber2TextEditingController = TextEditingController();
    
    if (widget.shippingCompany !=null) {
    _phoneNumber2TextEditingController.text = widget.shippingCompany.phoneNumber2;
    _phoneNumber1TextEditingController.text = widget.shippingCompany.phoneNumber1;
    _notesTextEditingController.text = widget.shippingCompany.notes;
    _addressTextEditingController.text = widget.shippingCompany.address;
    _nameTextEditingController.text = widget.shippingCompany.name;
    }
     
    print(_shippingCompany.toMap().length);
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
    _addressTextEditingController?.dispose();
    _notesTextEditingController?.dispose();
    _phoneNumber1TextEditingController?.dispose();
    _phoneNumber2TextEditingController?.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
       appBar: AppBar(),
      body: ListView(
        children: _shippingCompany.toMap().entries.map(
          (map){
            return Text("data");
          }
        ).toList(),
      ),
    );
  }
}
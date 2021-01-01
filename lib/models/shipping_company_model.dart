
import 'package:moderation_tool/database/database_helper.dart';
import 'package:moderation_tool/contract/database_model.dart';

class ShippingCompany implements DatabaseModel{
    
  int id ;
  DateTime createdAt;
  DateTime updatedAt;
  bool status;
  String notes;
  String name;
  String address;
  String phoneNumber1;
  String phoneNumber2;

  ShippingCompany({this.id,this.phoneNumber2,this.phoneNumber1,this.notes,this.address,this.status,this.name,this.createdAt,this.updatedAt}){
    if(this.status==null) this.status = false;
  }
  ShippingCompany.fromMap(Map<String,dynamic> map){
    
   this.id = map['id'];
   this.name = map['name'];
   this.status = map['dark_mood']==1;
   this.address = map['address'];
   this.notes = map['notes'];
   this.phoneNumber1 = map['phone_number1'];
   this.phoneNumber2 = map['phone_number2'];
   this.createdAt = (map['created_at'])==null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['created_at']);
    this.updatedAt = (map['updated_at']) == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['updated_at']); 
  }
  @override
  Map<String,dynamic> toMap() {
    return {
      'id': this.id,
      'status': this.status==true?1:0,
      'address': this.address ,
      'notes' : this.notes,
      'name' : this.name,
      'phone_number1' : this.phoneNumber1,
      'phone_number2' : this.phoneNumber2,        
      'created_at': ((this.createdAt == null)
          ? DateTime.now().millisecondsSinceEpoch
          : this.createdAt.millisecondsSinceEpoch),
      'updated_at': ((this.updatedAt == null)
          ? null
          : this.updatedAt.millisecondsSinceEpoch),
    };
  }

  @override
  int get modelID => this.id;
  
  @override
  String get table => 'shipping_company';

  @override
  Future<int> saveToDB() async {
    MyDatabase database = MyDatabase();
    int id = await database.insert(this);
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> getTableFromDB()async{
    MyDatabase database = MyDatabase();
    return await database.getTableData(this);
  }

  @override
  Future<int> updateRowDB()async{
    MyDatabase database = MyDatabase();
    return await database.updateRawByCoulmnValue(this);
  }
  @override
  Future<int> deleteRowDB()async{
    MyDatabase database = MyDatabase();
    return await database.updateRawByCoulmnValue(this);
  }

  @override
  Future<List<Map<String,dynamic>>> selectRowDB()async{
  MyDatabase database = MyDatabase();
  return await database.selectRow(this); 
  }

  @override
  Future<int> deleteFromDB()async{
    MyDatabase database = MyDatabase();
  return await database.deleteRow(this); 
  }
  }
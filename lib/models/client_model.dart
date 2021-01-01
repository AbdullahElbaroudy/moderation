

import 'package:moderation_tool/database/database_helper.dart';
import 'package:moderation_tool/contract/database_model.dart';

class Client implements DatabaseModel{


  int id ;
  String notes;
  String name;
  String address;
  String phoneNumber1;
  String phoneNumber2;
  DateTime createdAt;
  DateTime updatedAt;

  Client({this.notes,this.name,this.id,this.createdAt,this.updatedAt,this.address,this.phoneNumber1,this.phoneNumber2});

   Client.fromMap(Map<String,dynamic>map){
     this.id = map['id'];
     this.name = map['name'];
     this.notes = map['notes'];
     this.address = map['address'];
     this.phoneNumber1 = map['phone_number1'];
     this.phoneNumber2 = map['phone_number2'];
     this.createdAt = (map['created_at']) == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['created_at']);
    this.updatedAt = (map['updated_at']) == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['updated_at']);
   }

  @override
  Map<String,dynamic> toMap() {
    return {
      'id': this.id ,
      'name': this.name,
      'address': this.address,
      'phone_number1': this.phoneNumber1,
      'phone_number2': this.phoneNumber2,
      'notes': this.notes,
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
  String get table => 'clients';

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
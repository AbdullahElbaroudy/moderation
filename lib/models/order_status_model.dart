

import 'package:moderation_tool/database/database_helper.dart';
import 'package:moderation_tool/contract/database_model.dart';

class OrderStatus implements DatabaseModel{

  int id;
  String color;
  String statusName;
  String notes;
  DateTime createdAt;
  DateTime updatedAt;

  OrderStatus({this.statusName,this.notes,this.color,this.updatedAt,this.createdAt,this.id});
  
  OrderStatus.fromMap(Map<String,dynamic> map ){
    this.id= map['id'];
    this.color= map['color'];
    this.notes = map['notes'];
    this.statusName = map['status_name'];
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
      'id' : this.id,
      'color' : this.color,
      'notes': this.notes,
      'status_name' : this.statusName,
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
  String get table => 'order_status';

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
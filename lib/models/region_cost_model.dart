

import 'package:moderation_tool/database/database_helper.dart';
import 'package:moderation_tool/contract/database_model.dart';

class RegionCost implements DatabaseModel{
  int id ;
  double cost ;
  int companyID;
  String name;
  String notes;
  DateTime createdAt;
  DateTime updatedAt;
  
  RegionCost({this.id,this.updatedAt,this.createdAt,this.name,this.notes,this.cost,this.companyID});
  
  RegionCost.fromMap(Map<String,dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
    this.notes = map['notes'];
    this.cost = double.parse(map['cost']);
    this.companyID = map['company_id'];
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
      'id': this.id,
      'name': this.name ,
      'notes':this.notes ,
      'company_id': this.companyID ,
      'cost': this.cost.toString() ,
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
  String get table => 'region_cost';

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
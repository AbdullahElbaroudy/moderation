import 'package:moderation_tool/database/database_helper.dart';
import 'package:moderation_tool/contract/database_model.dart';

class Order implements DatabaseModel {
  int id;
  String notes;
  int statusID;
  int billNumber;
  int clientID;
  int userID;
  int regionID;
  double discount;
  DateTime createdAt;
  DateTime updatedAt;

  @override
  int get modelID => this.id;

  @override
  String get table => 'orders';

  Order.fromMap(Map<String,dynamic>map){
    this.id = map['id'];
    this.billNumber = map['bill_number'];
    this.regionID = map['region_id'];
    this.statusID = map['status_id'];
    this.userID = map['user_id'];
    this.clientID = map['client_id'];
    this.discount = double.parse(map['discount']);
    this.notes = map['notes'];
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
      'region_id': this.regionID,
      'status_id': this.statusID,
      'user_id': this.userID,
      'notes': this.notes,
      'discount': this.discount.toString(),
      'client_id': this.clientID,
      'bill_number': this.billNumber,
      'created_at': ((this.createdAt == null)
          ? DateTime.now().millisecondsSinceEpoch
          : this.createdAt.millisecondsSinceEpoch),
      'updated_at': ((this.updatedAt == null)
          ? null
          : this.updatedAt.millisecondsSinceEpoch),
    };  
  }

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

import 'package:moderation_tool/database/database_helper.dart';
import 'package:moderation_tool/contract/database_model.dart';

class Navigators implements DatabaseModel {
  int id;
  String navigationTitle;
  DateTime createdAt;
  bool status;
  int userID;

  @override
  String get table => 'navigators';

  @override
  int get modelID => this.id;

  Navigators(
      {this.id,
      this.createdAt,
      this.navigationTitle,
      this.status,
      this.userID}) {
    if (this.status == null) this.status = false;
    //if (navigationTitle == null) throw NullThrownError();
    // if (userID == null) throw NullThrownError();
  }

  Navigators.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.navigationTitle = map['navigation_title'];
    this.userID = map['user_id'];
    this.createdAt = (map['created_at']) == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['created_at']);
    this.status = (map['status'] == 1);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'navigation_title': this.navigationTitle,
      'status': this.status == true ? 1 : 0,
      'user_id': this.userID,
      'created_at': ((this.createdAt == null)
          ? DateTime.now().millisecondsSinceEpoch
          : this.createdAt.millisecondsSinceEpoch)
    };
  }

  @override
  Future<int> saveToDB() async {
    MyDatabase database = MyDatabase();
    int id = await database.insert(this);
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> getTableFromDB() async {
    MyDatabase database = MyDatabase();
    return await database.getTableData(this);
  }

  @override
  Future<int> updateRowDB() async {
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


import 'package:moderation_tool/database/database_helper.dart';
import 'package:moderation_tool/contract/database_model.dart';

class Products  implements DatabaseModel {
  
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String type;
  String color;
  int vailableNumber;
  String image;
  double cost;
 @override
  int get modelID => this.id;
 @override
  String get table => 'products';

  Products(
      {this.id,
      this.createdAt,
      this.name,
      this.updatedAt,
      this.color,
      this.cost,
      this.image,
      this.type,
      this.vailableNumber});

  Products.fromMap(Map<String, dynamic> map) {
    this.color = map['color'];
    this.cost = double.parse(map['cost']);
    this.vailableNumber = map['vailable_number'];
    this.type = map['type'];
    this.name = map['name'];
    this.image = map['image'];
    this.id = map['id'];
    this.createdAt = (map['created_at']) == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['created_at']);
    this.updatedAt = (map['updated_at']) == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['updated_at']);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'color': this.color,
      'cost': this.cost.toString(),
      'vailable_number': this.vailableNumber,
      'type': this.type,
      'name': this.name,
      'image': this.image,
      'id': this.id,
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

import 'package:moderation_tool/database/database_helper.dart';
import 'package:moderation_tool/contract/database_model.dart';

class Cart implements DatabaseModel {

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int orderID;
  int requiredNumber;
  int productID;
  double discount;

  Cart.fromMap(Map<String,dynamic> map){
    this.discount = double.parse(map['discount']);
    this.id = map['id'];
    this.orderID = map['order_id'];
    this.productID = map['product_id'];
    this.requiredNumber =map['required_number'];
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
      'discount': this.discount.toString(),
      'product_id': this.productID,
      'required_number': this.requiredNumber,
      'order_id': this.orderID,
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
  String get table => 'carts';

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
  Future<int> deleteRowDB() async {
    MyDatabase database = MyDatabase();
    return await database.updateRawByCoulmnValue(this);
  }

  @override
  Future<List<Map<String, dynamic>>> selectRowDB() async {
    MyDatabase database = MyDatabase();
    return await database.selectRow(this);
  }

  @override
  Future<int> deleteFromDB() async {
    MyDatabase database = MyDatabase();
    return await database.deleteRow(this);
  }
}

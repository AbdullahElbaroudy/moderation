
import 'package:moderation_tool/database/database_helper.dart';
import 'package:moderation_tool/contract/database_model.dart';
import 'package:moderation_tool/models/settings_model.dart';

class User implements DatabaseModel {
  int id;
  String userName;
  String name;
  String password;
  String picture;
  String phoneNumber;
  DateTime birthDate;
  DateTime createdAt;
  DateTime updatedAt;
  Setting setting;
  bool isExpanded;
  User(
      {this.id,
      this.setting,
      this.userName,
      this.name,
      this.password,
      this.phoneNumber,
      this.picture,
      this.birthDate,
      this.createdAt,
      this.isExpanded,
      this.updatedAt}) {
    this.setting = (this.setting == null) ? Setting() : this.setting;
    this.isExpanded=this.isExpanded??false;
  }

  @override
  int get modelID => this.id;

  @override
  String get table => 'users';

  User.fromMap(Map<String, dynamic> map) {
    this.setting = Setting(
        lang: map['language'],
        isDark: map['dark_mood'] == 1,
        favoriteColor: map['favorite_color']);
    this.id = map['id'];
    this.name = map['name'];
    this.password = map['password'];
    this.picture = map['picture'];
    this.userName = map['user_name'];
    this.phoneNumber = map['phone_number'];
    this.birthDate = (map['birth_date']) == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['birth_date']);
    this.createdAt = (map['created_at']) == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['created_at']);
    this.updatedAt = (map['updated_at']) == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(map['updated_at']);
  }

  dynamic nullability(var base, var nullValue) {
    base = (base == null) ? nullValue : base;
    print("base = $base");
    return base;
  }

  @override
  Map<String, dynamic> toMap() {
       return {
      'language': nullability(this.setting.lang, 'en'),
      'dark_mood': this.setting.isDark == true ? 1 : 0,
      'favorite_color': this.setting.favoriteColor,
      'name': this.name,
      'user_name': this.userName,
      'password': this.password,
      'picture': this.picture,
      'phone_number': this.phoneNumber,
      'birth_date': ((this.birthDate == null)
          ? null
          : this.birthDate.millisecondsSinceEpoch),
      'created_at': ((this.createdAt == null)
          ? DateTime.now().millisecondsSinceEpoch
          : this.createdAt.millisecondsSinceEpoch),
      'updated_at': ((this.updatedAt == null)
          ? null
          : this.updatedAt.millisecondsSinceEpoch),
    };
  }

  Future<int> update(
      {List<String> updateCoulmnNames,
      List<String> updateCoulmnValues,
      List<String> whereCoulmnNames,
      List<String> whereCoulmnValues}) async {
    MyDatabase database = MyDatabase();
    int n = await database.updateRawByCoulmnValue(this,
        updateCoulmnNames: updateCoulmnNames,
        updateCoulmnValues: updateCoulmnValues,
        whereCoulmnNames: whereCoulmnNames,
        whereCoulmnValues: whereCoulmnValues);
        return n;
  }
  updateBirthDate()async{
    MyDatabase database = MyDatabase();
    await database.coulmnUpdate(this,'birth_date',this.birthDate.millisecondsSinceEpoch);
  }
  Future<int> updateSetting()async{
    MyDatabase database = MyDatabase();
    int n = await database.updateRawByCoulmnValue(this,updateCoulmnNames: ['language','dark_mood','favorite_color'],updateCoulmnValues: [this.setting.lang,this.setting.isDark==true ?'1':'0',this.setting.favoriteColor]);
    return n;
  }

  Future<List<Map<String, dynamic>>> his({DatabaseModel databaseModel,List<String> coulmnNames,List<String> coulmnValues}) async {
    MyDatabase database = MyDatabase();
    if (coulmnNames == null) {
      coulmnNames = [];
      coulmnValues = [];
    }
    print(
        "databaseMode ${databaseModel == null} coulmnNames ${coulmnNames.length}  coulmnvalues ${coulmnValues.length}");
    try {
      if (databaseModel == null && coulmnNames.isEmpty) {
        print("object1111111111");
        databaseModel = this;
        coulmnNames.add('id');
        coulmnValues.add('${this.id.toString()}');
      } else if (databaseModel == null && coulmnNames.isNotEmpty) {
        print("object222222222");
        databaseModel = this;
      } else if (databaseModel != null && coulmnNames.isNotEmpty) {
        print("object33333333333333");
        databaseModel.table == this.table
            ? coulmnNames.add('id')
            : coulmnNames.add('user_id');
        coulmnValues.add('${this.id.toString()}');
      } else if (databaseModel != null && coulmnNames.isEmpty) {
        print("object444444444444");
        coulmnNames.add('user_id');
        coulmnValues.add('${this.id.toString()}');
      }
      return await database.selectRowByCoulmnsValue(databaseModel,
          coulmnNames: coulmnNames, coulmnValues: coulmnValues);
    } catch (e) {
      print(e);
    }
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

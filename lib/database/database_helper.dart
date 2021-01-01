import 'package:moderation_tool/contract/database_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  MyDatabase.internal();
  static final MyDatabase _myDatabase = MyDatabase.internal();
  factory MyDatabase() => _myDatabase;
  static Database db;

  Future<Database> localDatabase() async {
    if (db != null) {
      return db;
    } else {
      return db = await openDatabase(
          join(await getDatabasesPath(), 'eshtrakat.db'),
          version: 1,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onConfigure: _onConfigure);
    }
  }

  _onCreate(Database db, int ver) async {
    //user
    await db.execute(
        'create table users(id integer primary key autoincrement,updated_at integer,'
        'user_name varchar(200),name varchar(50),picture varchar(500),created_at integer,'
        'phone_number varchar(50),dark_mood BOOLEAN DEFAULT 0,language varchar(3) DEFAULT (\'en\'),'
        'favorite_color varchar(10),password varchar(100),birth_date integer )');
    //navigator
    await db.execute(
        'create table navigators(id integer primary key autoincrement,navigation_title varchar(20),created_at integer,'
        'status BOOLEAN DEFAULT 0,user_id integer, FOREIGN KEY(user_id) REFERENCES users(id) )');
    //client
    await db.execute(
        'create table clients(id integer primary key autoincrement,created_at integer,updated_at integer,'
        'name varchar(100),address varchar(100),phone_number1 varchar(11),phone_number2 varchar(11),'
        'notes varchar(10))');
    //products
    await db.execute(
        'create table products(id integer primary key autoincrement,name varchar(100),updated_at integer,created_at integer,'
        'type varchar(100) , color varchar(30),vailable_number integer,image varchar(500),cost varchar(100) )');
    //orders
    await db.execute(
        'create table orders(id integer primary key autoincrement,updated_at integer,created_at integer,'
        'notes varchar(500),status_id integer,bill_number integer,discount varchar(3),client_id integer,user_id integer,region_id integer,'
        'FOREIGN KEY(user_id) REFERENCES users(id) ,FOREIGN KEY(region_id) REFERENCES region_cost(id),'
        'FOREIGN KEY(status_id) REFERENCES order_status(id),FOREIGN KEY(client_id) REFERENCES clients(id) )');
     //status
     await db.execute(
        'create table order_status(id integer primary key autoincrement,color varchar(10),updated_at integer,created_at integer,'
        'notes varchar(500),status_name varchar(150) )');
    
    //Shipping company
    await db.execute(
        'create table shipping_company(id integer primary key autoincrement,updated_at integer,created_at integer,'
        'notes varchar(500),status integer,name varchar(100),address varchar(500),phone_number1 varchar(11),phone_number2 varchar(11))');
     //region_cost
    await db.execute(
        'create table region_cost(id integer primary key autoincrement,updated_at integer,created_at integer,'
        'notes varchar(500),name varchar(100),cost varchar(100),company_id integer ,FOREIGN KEY(company_id) REFERENCES shipping_company(id))');
    //cart
    await db.execute(
        'create table carts(id integer primary key autoincrement,updated_at integer,'
        'product_id integer,order_id integer,required_number integer,discount varchar(3),'
        ' FOREIGN KEY(product_id) REFERENCES products(id) ,FOREIGN KEY(order_id) REFERENCES orders(id) ) ');
    /*//cart_history
    await db.execute(
        'create table carts_history(id integer primary key autoincrement,updated_at integer,'
        'product_id integer,cart_id integer,order_id integer,required_number integer,'
        'FOREIGN KEY(product_id) REFERENCES products(id) ,FOREIGN KEY(order_id) REFERENCES orders(id)'
        ' )');*/
  }

  _onUpgrade(Database db, int verOld, int verNew) {}

  Future _onConfigure(Database db) async {
    print("from configure");
    await db.execute('PRAGMA foreign_keys = ON'); //to enable forign key
  }

  Future<int> insert(DatabaseModel databaseModel) async {
    Database db = await localDatabase();
    int n = await db.insert(databaseModel.table, databaseModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return n;
  }
  
  Future<int> updateTable(DatabaseModel databaseModel) async {
    Database db = await localDatabase();
    return await db.update(databaseModel.table, databaseModel.toMap());
  }

  Future<int> coulmnUpdate(
      DatabaseModel databaseModel, String coulmnName, dynamic value) async {
    Database db = await localDatabase();
    return await db.rawUpdate(
        'UPDATE ${databaseModel.table} SET ${coulmnName} = ? WHERE id = ?',
        [value, databaseModel.modelID]);
  }

  Future<List<Map<String, dynamic>>> getTableData(DatabaseModel databaseModel) async {
    List<Map<String, dynamic>> maps = List();
    Database db = await localDatabase();
    maps = await db.query(databaseModel.table);
    print("froooom get table from databaseHelper file #####${databaseModel.table}##### data ${maps}");
    return maps;
  }

  Future<int> deletAllTableData(DatabaseModel databaseModel) async {
    Database db = await localDatabase();
    await db.rawUpdate('UPDATE sqlite_sequence SET seq = ? WHERE name = ?',[0,databaseModel.table]);//reset sequance counter
    return await db.delete(databaseModel.table);
  }

  Future<int> deleteRow(DatabaseModel databaseModel) async {
    Database db = await localDatabase();
    return await db.delete(databaseModel.table,
        where: 'id = ?', whereArgs: [databaseModel.modelID]);
  }
  

  Future<int> updateRawByCoulmnValue(DatabaseModel databaseModel,
      {List<String> updateCoulmnNames,
      List<String> updateCoulmnValues,
      List<String> whereCoulmnNames,
      List<String> whereCoulmnValues}) async {
    updateCoulmnNames = updateCoulmnNames ?? [];
    updateCoulmnValues = updateCoulmnValues ?? [];
    whereCoulmnNames = whereCoulmnNames ?? [];
    whereCoulmnValues = whereCoulmnValues ?? [];
    Database db = await localDatabase();
    String sqlWhere;
    String sqlSet;
    try {
      
    if (updateCoulmnNames.isNotEmpty) {
      for (var i = 0; i < updateCoulmnNames.length; i++) {
        if (i == updateCoulmnNames.length - 1) {
          sqlSet = '${sqlSet ?? ''} ${updateCoulmnNames[i]}=?';
        } else {
          sqlSet = '${sqlSet ?? ''} ${updateCoulmnNames[i]}=? ,';
        }
      }
      
    } else {
      print("frooooooooom here eles");
      if(databaseModel.modelID==null)throw('############\nExeption : id of raw will be updated is null');
      return await db.update(databaseModel.table, databaseModel.toMap(),where: 'id = ?',whereArgs: [databaseModel.modelID]);
    }
    if (whereCoulmnNames.isNotEmpty) {
        for (var i = 0; i < whereCoulmnNames.length; i++) {
          if (i == whereCoulmnNames.length - 1) {
            sqlWhere =
                '${sqlWhere == null ? '' : sqlWhere} ${whereCoulmnNames[i]}= ?';
          } else {
            sqlWhere =
                '${sqlWhere == null ? '' : sqlWhere} ${whereCoulmnNames[i]}= ? AND';
          }
        }
       
      } else {
        if (databaseModel.modelID == null)
          throw ('Exeption : for check is this model excistance you should'
              ' declear  id of database model becouse it is a null ${databaseModel.table}.id =${databaseModel.modelID}');
        sqlWhere = ' id = ?';
        print("update id = ${databaseModel.modelID}");
        print("updateCoulmnValues = ${updateCoulmnValues}");
        print("updateCoulmnNames = ${updateCoulmnNames}");
        whereCoulmnValues.add(databaseModel.modelID.toString());
      }
     print("sqlUpdate = $sqlSet ##### sqlWhere = $sqlWhere");
    await db.rawUpdate(
        'UPDATE ${databaseModel.table} SET ${sqlSet} WHERE ${sqlWhere}',
        updateCoulmnValues+whereCoulmnValues);
        
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> selectRowByCoulmnsValue(
      DatabaseModel databaseModel,
      {List<String> coulmnNames,
      List<String> coulmnValues}) async {
    Database db = await localDatabase();
    String sqlWhere;
    print("coulmn names =${coulmnNames}");
    if (coulmnNames.isNotEmpty) {
      for (var i = 0; i < coulmnNames.length; i++) {
        if (i == coulmnNames.length - 1) {
          sqlWhere = '${sqlWhere == null ? '' : sqlWhere} ${coulmnNames[i]}= ?';
        } else {
          sqlWhere =
              '${sqlWhere == null ? '' : sqlWhere} ${coulmnNames[i]}= ? AND';
        }
      }
      print("sqlWhere = $sqlWhere");
    } else {
      if (databaseModel.modelID == null)
        throw ('Exeption : for check is this model excistance you should'
            ' declear  id of database model becouse it is a null ${databaseModel.table}.id =${databaseModel.modelID}');
      sqlWhere = ' id = ?';
    }
    List<Map<String, dynamic>> map = await db.rawQuery(
        'select * from ${databaseModel.table} where $sqlWhere',
        coulmnValues.isEmpty ? [databaseModel.modelID] : coulmnValues);
    print(map);
    return map;
  }

  Future<List<Map<String, dynamic>>> selectRow(
      DatabaseModel databaseModel) async {
    Database db = await localDatabase();
    List<Map<String, dynamic>> map = await db.query(databaseModel.table,
        where: 'id = ?', whereArgs: [databaseModel.modelID]);
    print(map);
    return map;
  }

  List<String> tables = List();

  Future<void> descTables() async {
    Database db = await localDatabase();
    try {
      /*
     to get all tables in your db u should use select query to get sqlite_master table
     in sqlite_master table u will find  4 coulms (type,name,//2 others) 
     if you want tables
     coulmn named 'type' has value = table 
     coulmn named 'name' has value = {name of table}
       */
      db
          .query("sqlite_master",
              columns: ['type', 'name'],
              where:
                  '(type = \'table\' AND name <>\'sqlite_sequence\' AND name <> \'android_metadata\' )')
          .then((value) {
        value.forEach((element) {
          print(element);
        });
        fromListMapToList(value);
      });
      tables.forEach((element) {
        print(element);
      });
    } catch (e) {
      print("$e");
    }
  }

  fromListMapToList(List<Map<String, dynamic>> listMap) {
    listMap.forEach((element) {
      element.forEach((key, value) {
        if (key == 'name') {
          tables.add(value);
        }
      });
    });
  }
}

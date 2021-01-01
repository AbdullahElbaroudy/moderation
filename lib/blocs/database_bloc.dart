import 'dart:async';

import 'package:moderation_tool/contract/disposable.dart';
import 'package:moderation_tool/contract/database_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseBloc implements Disposable {
  DatabaseModel _databaseModel;
  List<DatabaseModel> _listDatabaseModel = [];
  List<Map<String, dynamic>> mapList = [];

  final StreamController<DatabaseModel> _scInsertRowDB = StreamController<DatabaseModel>();
  Stream<DatabaseModel> get scInsertRowDBStream => _scInsertRowDB.stream;
  StreamSink<DatabaseModel> get scInsertRowDBSink => _scInsertRowDB.sink;
  StreamSubscription<DatabaseModel> insertingRowSubscription ;

  final StreamController _scDeleteRowDB = StreamController();
  Stream get scDeleteRowDBStream => _scDeleteRowDB.stream;
  StreamSink get scDeleteRowDBSink => _scDeleteRowDB.sink;

  final StreamController<DatabaseModel> _scDeleteRowReturnTableDB = StreamController<DatabaseModel>();
  Stream<DatabaseModel> get scDeleteRowReturnTableDBStream => _scDeleteRowReturnTableDB.stream;
  StreamSink<DatabaseModel> get scDeleteRowReturnTableDBSink => _scDeleteRowReturnTableDB.sink;
  StreamSubscription<DatabaseModel> deletingRowReturnTableSubscription ;

  final StreamController<DatabaseModel> _scUpdateRowDB = StreamController<DatabaseModel>.broadcast();
  Stream<DatabaseModel> get scUpdateRowDBStream => _scUpdateRowDB.stream;
  StreamSink<DatabaseModel> get scUpdateRowDBSink => _scUpdateRowDB.sink;
  StreamSubscription<DatabaseModel> updatingRowSubscription ;


  final StreamController<DatabaseModel> _scUpdateReturnTableDB = StreamController<DatabaseModel>.broadcast();
  Stream<DatabaseModel> get scUpdateReturnTableDBStream => _scUpdateReturnTableDB.stream;
  StreamSink<DatabaseModel> get scUpdateReturnTableDBSink => _scUpdateReturnTableDB.sink;
  StreamSubscription<DatabaseModel> updatingReturnSubscription;


  final StreamController<DatabaseModel> _scSelectRowDB = StreamController<DatabaseModel>.broadcast();
  Stream<DatabaseModel> get scSelectRowDBStream => _scSelectRowDB.stream;
  StreamSink<DatabaseModel> get scSelectRowDBSink => _scSelectRowDB.sink;
  StreamSubscription<DatabaseModel> selectingRowSubscription;

  final StreamController<List<Map<String, dynamic>>> _scRowDB = StreamController<List<Map<String, dynamic>>>.broadcast();
  Stream<List<Map<String, dynamic>>> get scRowDBStream => _scRowDB.stream;
  StreamSink<List<Map<String, dynamic>>> get scRowDBSink => _scRowDB.sink;
  StreamSubscription<List<Map<String, dynamic>>> requestingRowSubscription;


  final StreamController<List<Map<String, dynamic>>> _scTableDB =StreamController<List<Map<String, dynamic>>>.broadcast();
  Stream<List<Map<String, dynamic>>> get scTableDBStream => _scTableDB.stream;
  StreamSink get scTableDBSink => _scTableDB.sink;
  //////////
  final StreamController<DatabaseModel> _scSelectTableDB = StreamController<DatabaseModel>.broadcast();
  StreamSink<DatabaseModel> get scSelectTableDBSink => _scSelectTableDB.sink;
  Stream<DatabaseModel> get scSelectTableDBStream => _scSelectTableDB.stream;

  final StreamController<DatabaseModel> _scSelectTableWithOutModelNowDB = StreamController<DatabaseModel>.broadcast();
  StreamSink<DatabaseModel> get scSelectTableWithOutModelNowDBSink => _scSelectTableWithOutModelNowDB.sink;
  Stream<DatabaseModel> get scSelectTableWithOutModelNowDBStream => _scSelectTableWithOutModelNowDB.stream;

  StreamSubscription<DatabaseModel> requestingTableSubscription;
  StreamSubscription<DatabaseModel> requestingTableWithOutModelNowSubscription;

  /////////
  _insert(DatabaseModel databaseModel)async{
    await databaseModel.saveToDB(); 
    print("maaaaaaaaaaaaaaaaaaaaaap = ${await databaseModel.getTableFromDB()}");
  }
  DataBaseBloc() {
    insertingRowSubscription = scInsertRowDBStream.listen(_insert);
    updatingReturnSubscription = scUpdateReturnTableDBStream.listen(_updateReturningTable);
    requestingTableSubscription = scSelectTableDBStream.listen(_getTable);
    requestingTableWithOutModelNowSubscription =scSelectTableWithOutModelNowDBStream.listen(_getTableWithOutModelNow);
    updatingRowSubscription = scUpdateRowDBStream.listen(_update);
    selectingRowSubscription =scSelectRowDBStream.listen(_selectRow);
    deletingRowReturnTableSubscription = scDeleteRowReturnTableDBStream.listen(_deleteReturningTable);
  } 
  _updateReturningTable(DatabaseModel databaseModel)async{
    await databaseModel.updateRowDB();
    scTableDBSink.add(await databaseModel.getTableFromDB());
    }
    _deleteReturningTable(DatabaseModel databaseModel)async{
    await databaseModel.deleteFromDB();
    scTableDBSink.add(await databaseModel.getTableFromDB());
    }
   _selectRow(DatabaseModel _databaseModel )async{
     scTableDBSink.add(await _databaseModel.selectRowDB());
   }
  _getTable(DatabaseModel databaseModel) async {
    scTableDBSink.add(await databaseModel.getTableFromDB());
  }
  _getTableWithOutModelNow(DatabaseModel databaseModel) async {//to get all ttable data without user signed in now
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int me = sharedPreferences.getInt('user_id');
    List<Map<String, dynamic>> maps =[];
    await databaseModel.getTableFromDB().then((readMaps) {
      readMaps.forEach((mapRead) {
        Map<String, dynamic> map = Map<String, dynamic>.from(mapRead);
        if (map['id'] != me) {
          print("me =$me  map[id]${map['id']}");
          maps.add(map);
        }
      });
    });
    scTableDBSink.add(maps);
  }
   _update(DatabaseModel databaseModel)async{
    await databaseModel.updateRowDB();
    scTableDBSink.add(await databaseModel.selectRowDB());
  }
  @override
  dispose() {
    /*_scSelectNavigatorWithUserIdDB.close();
    selectingNavigatorWithUserIdSubscription.cancel();*/
    deletingRowReturnTableSubscription.cancel();
    _scDeleteRowReturnTableDB.close();
    insertingRowSubscription.cancel();
updatingReturnSubscription.cancel();
_scUpdateReturnTableDB.close();
    requestingRowSubscription?.cancel();
    _scRowDB?.close();
    selectingRowSubscription?.cancel();
    updatingRowSubscription?.cancel();
    requestingTableWithOutModelNowSubscription?.cancel();
    requestingTableSubscription?.cancel();
    _scTableDB.close();
    _scInsertRowDB.close();
    _scSelectTableDB.close();
    _scSelectTableWithOutModelNowDB.close();
    _scSelectRowDB.close();
    _scDeleteRowDB.close();
    _scUpdateRowDB.close();
  }
}

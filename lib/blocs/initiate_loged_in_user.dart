import 'dart:async';
import 'package:moderation_tool/contract/disposable.dart';
import 'package:moderation_tool/models/settings_model.dart';
import 'package:moderation_tool/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitiateLogedInUserBloc implements Disposable {
  //constractor
  InitiateLogedInUserBloc(){
    print("hello from InitiateLogedInUserBloc._internal() constractor");
    scUpdateStream.listen(_updateUserSetting);
    getUser();
  }
  void _updateUserSetting(Setting setting)async{
    SharedPreferences _sharedPrefrences = await SharedPreferences.getInstance();
    int id = await _sharedPrefrences.get('user_id');
    User _user = User(id:id,setting:setting);
    await _user.updateSetting();
    await _user.his().then((mapList) {
      if (mapList.isEmpty) {
        _scInitiateLogedInUser.sink.add(User());
      } else {
        mapList.forEach((map) {
          _scInitiateLogedInUser.sink.add(User.fromMap(map));
        });
      }
      //mapList.isNotEmpty?_scInitiateLogedInUser.sink.add(true):   _scInitiateLogedInUser.sink.add(false);
    });
  }
  

  /*
  static final InitiateLogedInUserBloc _initiateLogedInUser =
      InitiateLogedInUserBloc._internal();
  factory InitiateLogedInUserBloc() => _initiateLogedInUser;*/


  final StreamController<User> _scInitiateLogedInUser =
      StreamController<User>.broadcast();
  StreamSink<User> get scInitiateLogedInUserSink => _scInitiateLogedInUser.sink;
  Stream<User> get scInitiateLogedInUserStream => _scInitiateLogedInUser.stream;
  /////////////////////////////////
  final StreamController<Setting> _scUpdateUser =
      StreamController<Setting>.broadcast();
  StreamSink<Setting> get scUpdateSink => _scUpdateUser.sink;
  Stream<Setting> get scUpdateStream => _scUpdateUser.stream;
  /////////////////////////////////
  
  getUser() async {
    print("froooom get user");
    SharedPreferences _sharedPrefrences = await SharedPreferences.getInstance();
    int id = await _sharedPrefrences.get('user_id');
    print("froooom get user id = ${id}");
    await User(id: id).his().then((mapList) {
      if (mapList==null) {
        _scInitiateLogedInUser.sink.add(User());
      }else if(mapList.isEmpty){ _scInitiateLogedInUser.sink.add(User());} 
      else {
        mapList.forEach((map) {
          _scInitiateLogedInUser.sink.add(User.fromMap(map));
        });
      }
      //mapList.isNotEmpty?_scInitiateLogedInUser.sink.add(true):   _scInitiateLogedInUser.sink.add(false);
    });
  }

  @override
  dispose() {
    _scInitiateLogedInUser?.close();
    _scUpdateUser?.close();
  }
}

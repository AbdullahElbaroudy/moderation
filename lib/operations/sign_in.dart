import 'package:moderation_tool/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn {
  Future<bool> exitUser() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    return await _sharedPreferences.remove('user_id');
  }

  Future<User> signInWithUserNameAndPassword(
    String userName, String password) async {
    User _user;
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> mapList =await User().his(
        coulmnNames: ['user_name', 'password'],
        coulmnValues: [userName, password]);
          if (mapList.isEmpty) {
          return User();
        }  
      mapList.forEach((map) {
        print(map);
        _user = User.fromMap(map);
      });
    await _sharedPreferences.setInt('user_id', _user.id);
    return _user;
  }
}

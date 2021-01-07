
import 'package:moderation_tool/models/navigator_model.dart';
import 'package:moderation_tool/models/settings_model.dart';
import 'package:moderation_tool/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp {
  Future<User> signUpWithUserNameAndPassword(
      String userName, String password) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    User _user = User(
      userName: userName.toLowerCase().trim(),
      password: password,
      setting: Setting(),
    );

    List<Map<String, dynamic>> userList =
        await _user.his(coulmnNames: ['user_name'], coulmnValues: [userName]);
    if (userList.isEmpty) {
      int id = await _user.saveToDB();
      await Navigators(userID: id, navigationTitle: 'settings', status: true)
          .saveToDB();
      await Navigators(userID: id, navigationTitle: 'sign_out', status: true)
          .saveToDB();
       await Navigators(userID: id, navigationTitle: 'my_profile', status: true)
          .saveToDB();
      if (userName == 'admin') {
            await Navigators(
                userID: id, navigationTitle: 'navigators', status: true)
            .saveToDB();
            await Navigators(
                userID: id, navigationTitle: 'products', status: true)
            .saveToDB();
             await Navigators(
                userID: id, navigationTitle: 'shipping_company', status: true)
            .saveToDB();
            await Navigators(
                userID: id, navigationTitle: 'orders', status: true)
            .saveToDB();
      } else {
        await Navigators(
                userID: id, navigationTitle: 'navigators', status: false)
            .saveToDB();
            await Navigators(
                userID: id, navigationTitle: 'products', status: false)
            .saveToDB();
             await Navigators(
                userID: id, navigationTitle: 'shipping_company', status: false)
            .saveToDB();
            await Navigators(
                userID: id, navigationTitle: 'orders', status: false)
            .saveToDB();
      }
      await _sharedPreferences.setInt('user_id', id);
      return _user = User(id: id, userName: userName, password: password);
    } else {
      return User();
    }
  }
}

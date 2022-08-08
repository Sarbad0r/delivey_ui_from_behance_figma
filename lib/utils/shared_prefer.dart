import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefer {
  static SharedPreferences? shared;
  static Future init() async {
    shared = await SharedPreferences.getInstance();
  }

  Future<void> setToken(String getToken) async {
    await shared?.setString("token", getToken);
  }

  Future<String> getToken() async {
    String? token = shared?.getString('token');
    return token?.trim() ?? '';
  }

  Future<void> deleteToken() async {
    shared?.remove("token");
  }

  ///
  ///
  ///user|

  Future<void> setUserName(String name) async {
    await shared?.setString('userName', name);
  }

  Future<void> setUserId(int id) async {
    await shared?.setInt("userId", id);
  }

  Future<void> setUserEmail(String email) async {
    await shared?.setString("userEmail", email);
  }

  ///get user things

  Future<int> getUserID() async {
    int? id = 0;
    id = shared?.getInt('userId');
    return id ?? 0;
  }

  Future<String> getUserEmail() async {
    String? email;
    email = shared?.getString("userEmail");
    return email ?? '';
  }

  Future<String> getUserName() async {
    String? email;
    email = shared?.getString("userName");
    return email ?? '';
  }
}

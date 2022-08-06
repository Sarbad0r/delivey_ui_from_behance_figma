import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefer {
  static SharedPreferences? shared;
  static Future init() async {
    shared = await SharedPreferences.getInstance();
  }

  Future<void> setToken(String getToken) async {
    await shared?.setString("token", getToken);
  }

  Future<String?> getToken() async {
    return await shared?.getString('token');
  }
}

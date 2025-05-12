import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static bool? isLogin;
  static String? email;
  static Future<void> storeSessionData(
      {required bool loginData, required String email}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
// SET DATA
    sharedPreferences.setBool("loginSession", loginData);
    sharedPreferences.setString("email", email);

// GET DATA
    getSessionData();
  }

  static Future<void> getSessionData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isLogin = sharedPreferences.getBool("loginSession") ?? false;
    email = sharedPreferences.getString("email") ?? "";
  }
}

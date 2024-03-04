import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDataSource {
  final SharedPreferences sharedPreferences;

  LocalStorageDataSource(this.sharedPreferences);

  Future<String?> getEmail() async {
    return sharedPreferences.getString('email');
  }

  Future<void> saveEmail(String email) async {
    await sharedPreferences.setString('email', email);
  }

  Future<String?> getPassword() async {
    return sharedPreferences.getString('password');
  }

  Future<void> savePassword(String password) async {
    await sharedPreferences.setString('password', password);
  }

  Future<void> saveRememberMe(bool value) async {
    await sharedPreferences.setBool('remember_me', value);
  }

  Future<void> clearUserData() async {
    await sharedPreferences.remove('email');
    await sharedPreferences.remove('password');
    await sharedPreferences.remove('remember_me');
  }
}

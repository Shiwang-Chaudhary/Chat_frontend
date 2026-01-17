import 'package:shared_preferences/shared_preferences.dart';

class StorageService{
  static Future<void> saveData(String token, String tokenKey)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getData(String tokenKey)async{
    final prefs = await SharedPreferences.getInstance();
   final String? token =  prefs.getString(tokenKey);
   return token;
  }
}
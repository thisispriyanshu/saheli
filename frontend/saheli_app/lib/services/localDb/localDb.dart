import 'package:shared_preferences/shared_preferences.dart';

class LocalDb{
  static const uidKey = '';
  static const eKey = '';
  static const pKey = '';
  static const rKey = '';

  static Future<bool> saveUserId(String uid) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(uidKey, uid);
  }

  //gets uid of user
  static Future<String?> getUserId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(uidKey);
  }

  static Future<bool> saveEmail(String name) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(eKey, name);
  }

  //gets email of user
  static Future<String?> getEmail() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(eKey);
  }

  static Future<bool> saveName(String profile) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(pKey, profile);
  }

  //gets name of user
  static Future<String?> getName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(pKey);
  }
}
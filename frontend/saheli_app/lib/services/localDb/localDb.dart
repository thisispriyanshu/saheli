import 'package:shared_preferences/shared_preferences.dart';

class LocalDb{
  static const uidKey = 'uuvgauwvasd';
  static const eKey = 'sndabwiefabwe';
  static const pKey = 'sadarbhvarev';
  static const rKey = 'awnfiawiufjkdsb';
  static const mKey = 'niaiewiaiuea';
  static const gKey = 'awbiaiubvabeva';
  static const dKey = ' ajbvuabawebjkwe';

  static Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    return isFirstTime;
  }

  static Future<void> setFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }

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

  static Future<bool> saveMobile(String mobile) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(mKey, mobile);
  }

  //gets name of user
  static Future<String?> getMobile() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(mKey);
  }

  static Future<bool> saveGender(String gender) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(gKey, gender);
  }

  //gets name of user
  static Future<String?> getGender() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(gKey);
  }

  static Future<bool> saveAge(String dob) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(dKey, dob);
  }

  //gets name of user
  static Future<String?> getAge() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(dKey);
  }
}
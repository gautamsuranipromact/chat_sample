import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? prefs;

  static String token = "TOKEN";
  static String name = "NAME";
  static String id = "ID";

  static Future<SharedPreferences?> init() async {
    if(prefs != null){
       return prefs;
    }else{
      prefs = await SharedPreferences.getInstance();
      return prefs;
    }
  }
}

import 'package:shared_preferences/shared_preferences.dart';
class CashHelper {
  int x = 0;
  static SharedPreferences? sharedPreferences;
  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveData(
      {required String key, required dynamic value,}) async {
     return await sharedPreferences?.setBool(key, value);
  }


  static bool? getData({
    required String key,
  }){
    return sharedPreferences?.getBool(key) ;
  }
}

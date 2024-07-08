
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper{
  static SharedPreferences ?sharedPreferences;
  static init()async{
    sharedPreferences= await SharedPreferences.getInstance();
  }

  static Future<bool> SaveData({
    required dynamic value,
    required String key
  })async{
    if(value is String){
      return await sharedPreferences!.setString(key, value);
    }
    else if(value is double){
      return await sharedPreferences!.setDouble(key,value);
    }
    else if(value is int)
    {
      return await sharedPreferences!.setInt(key, value);
    }
    else
    {
      return await sharedPreferences!.setBool(key, value);
    }

  }

  static dynamic GetData({
    required String key
  }){
    return sharedPreferences!.get(key);

  }

  static Future<bool> RemoveData({
    required String key
  })async{
    return await sharedPreferences!.remove(key);
  }

}
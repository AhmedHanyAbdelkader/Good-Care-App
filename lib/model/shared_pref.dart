import 'package:graduation_project/resources/strings_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocalData{
  stroeToken(String? token)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppStrings.token, token!);
  }


  readToken()async{
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getString(AppStrings.token);
  }

  removeToken()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppStrings.token);
  }



}
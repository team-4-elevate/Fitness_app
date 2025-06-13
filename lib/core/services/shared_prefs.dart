import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class SharedPreferencesService {
  Future<bool> saveString(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
    return true;
  }

  Future<String?> getString(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }
}

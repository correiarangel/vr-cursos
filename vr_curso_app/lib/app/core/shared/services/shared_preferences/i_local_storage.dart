
import 'package:shared_preferences/shared_preferences.dart';

import 'adapters/shared_params.dart';

abstract  class ILocalStorage {
  Future<bool> setData({required SharedParams params});
  dynamic getData(String key);
  Future<bool> removeData(String key);
  Future<List<String>?>? getList(String key);
  Future<SharedPreferences?>? init();
  Future<void> clearData();
}

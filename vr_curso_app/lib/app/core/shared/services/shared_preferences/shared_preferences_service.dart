import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vr_curso_app/app/core/shared/services/shared_preferences/i_local_storage.dart';

import '../../failures/sherad_preference_errors.dart';
import 'adapters/shared_params.dart';


class SharedPreferencesService implements ILocalStorage {
  SharedPreferences? sharedPreferences;
  SharedPreferencesService(SharedPreferences sharedPreferences) {
    init();
  }
  @override
  dynamic getData(String key) async {
    sharedPreferences ?? await init();
    final result = sharedPreferences?.get(key);
    if (result != null) return result;
    throw SharedPreferencesException(
        message: 'There is no key ($key) passed as a parameter',
        stackTrace: StackTrace.current);
  }

  @override
  Future<bool> setData({required SharedParams params}) async {
    sharedPreferences ?? await init();
    if (params.value.runtimeType == String) {
      return await sharedPreferences?.setString(params.key, params.value) ??
          false;
    }
    if (params.value.runtimeType == int) {
      return await sharedPreferences?.setInt(params.key, params.value) ?? false;
    }
    if (params.value.runtimeType == bool) {
      return await sharedPreferences?.setBool(params.key, params.value) ??
          false;
    }
    if (params.value.runtimeType == double) {
      return await sharedPreferences?.setDouble(params.key, params.value) ??
          false;
    }
    if (params.value.runtimeType == List<String>) {
      return await sharedPreferences?.setStringList(params.key, params.value) ??
          false;
    }

    return false;
  }

  @override
  Future<List<String>?>? getList(String key) async {
    sharedPreferences ?? await init();
    try {
      return sharedPreferences?.getStringList(key) ?? [];
    } on Exception catch (e) {
      log('ERROR getList', error: e.toString(), stackTrace: StackTrace.current);
      throw SharedPreferencesException(
        message: 'There is no key ($key) passed as a parameter',
        stackTrace: StackTrace.current,
      );
    }
  }

  @override
  Future<bool> removeData(String key) async {
    sharedPreferences ?? await init();
    return await sharedPreferences?.remove(key) ?? false;
  }

  @override
  Future<SharedPreferences?>? init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  @override
  Future<void> clearData() async {
    sharedPreferences ?? await init();
    await sharedPreferences?.clear() ?? false;
  }
}

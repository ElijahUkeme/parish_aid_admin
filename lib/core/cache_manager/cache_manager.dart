import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  //single instance of CacheManager i.e singleton
  static final CacheManager instance = CacheManager._();

  Future<SharedPreferences>? _sharedPref;

  CacheManager._() {
    init();
  }

  void init() {
    _sharedPref = SharedPreferences.getInstance();
  }

  Future<bool> storePref(String key, dynamic value) async {
    if (value is String) {
      return (await _sharedPref)!.setString(key, value);
    } else if (value is int) {
      return (await _sharedPref)!.setInt(key, value);
    } else if (value is double) {
      return (await _sharedPref)!.setDouble(key, value);
    } else if (value is List<String>) {
      return (await _sharedPref)!.setStringList(key, value);
    } else if (value is bool) {
      return (await _sharedPref)!.setBool(key, value);
    } else {
      throw const FormatException();
    }
  }

  //value Retrieval
  Future<dynamic> getPref(String key) async {
    return (await _sharedPref)!.get(key);
  }

  Future<Future<bool>> removeKey(String key) async {
    return (await _sharedPref)!.remove(key);
  }
}

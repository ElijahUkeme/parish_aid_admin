import 'dart:convert';

import 'package:parish_aid_admin/constants/app_url_constants.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/response/auth_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences _pref;
  Future<StorageService> initSharedPreference() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  bool getIsUserAlreadyLoggedIn() {
    return _pref.getString(AppUrlConstant.USER_ALREADY_LOGIN) == null
        ? false
        : true;
  }

  Future<bool> removeKey(String key) {
    return _pref.remove(key);
  }

  AuthUserModel? getUserDetails() {
    var offlineDetails =
        _pref.getString(AppUrlConstant.STORAGE_USER_PROFILE_KEY) ?? "";
    print("The offline details is $offlineDetails");
    if (offlineDetails.isNotEmpty) {
      return AuthUserModel.fromJson(json.decode(offlineDetails));
    }
    return null;
  }

  String getUserToken() {
    return _pref.getString(AppUrlConstant.USER_ALREADY_LOGIN) ?? "";
  }
}

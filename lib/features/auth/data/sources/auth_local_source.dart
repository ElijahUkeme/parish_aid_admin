import 'dart:convert';

import 'package:parish_aid_admin/api/api_client.dart';
import 'package:parish_aid_admin/core/cache_manager/cache_manager.dart';
import 'package:parish_aid_admin/core/utils/strings.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';

abstract class AuthLocalSource {
  Future<bool> cacheAuthToken(AuthUserModel data);
  Future<bool> clearAuthToken();
  Future<AuthUserModel?> getAuthToken();
}

class AuthLocalSourceImpl extends AuthLocalSource {
  @override
  Future<bool> cacheAuthToken(AuthUserModel data) async {
    return await CacheManager.instance
        .storePref(userTokenKey, json.encode(data.response!.data!.token!));
  }

  @override
  Future<bool> clearAuthToken() async {
    return await CacheManager.instance.storePref(userTokenKey, '');
  }

  @override
  Future<AuthUserModel?> getAuthToken() async {
    final authUserData =
        await CacheManager.instance.getPref(userTokenKey) as String?;
    if (authUserData != null && authUserData.isNotEmpty) {
      print(
          "The token returned from the local storage is ${AuthUserModel.fromJson(json.decode(authUserData))}");
      return AuthUserModel.fromJson(json.decode(authUserData));
    }
    return null;
  }
}

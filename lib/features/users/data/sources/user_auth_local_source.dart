import 'dart:convert';

import 'package:parish_aid_admin/core/utils/strings.dart';
import 'package:parish_aid_admin/features/users/data/models/user_auth_model.dart';

import '../../../../core/cache_manager/cache_manager.dart';

abstract class UserAuthLocalSource {
  Future<bool> cacheAuthToken(UserAuthModel data);
  Future<bool> clearAuthToken();
  Future<UserAuthModel?> getAuthToken();
}

class UserAuthLocalSourceImpl extends UserAuthLocalSource {
  @override
  Future<bool> cacheAuthToken(UserAuthModel data) async {
    return await CacheManager.instance
        .storePref(endUserTokenKey, json.encode(data.response!.data!.token!));
  }

  @override
  Future<bool> clearAuthToken() async {
    return await CacheManager.instance.storePref(endUserTokenKey, '');
  }

  @override
  Future<UserAuthModel?> getAuthToken() async {
    final authUserData =
        await CacheManager.instance.getPref(endUserTokenKey) as String?;
    if (authUserData != null && authUserData.isNotEmpty) {
      print(
          "The token returned from the local storage is ${UserAuthModel.fromJson(json.decode(authUserData))}");
      return UserAuthModel.fromJson(json.decode(authUserData));
    }
    return null;
  }
}

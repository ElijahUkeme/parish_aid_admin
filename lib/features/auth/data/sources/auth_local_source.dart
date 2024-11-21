import 'dart:convert';

import 'package:parish_aid_admin/api/api_client.dart';
import 'package:parish_aid_admin/core/cache_manager/cache_manager.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/core/utils/strings.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';

abstract class AuthLocalSource {
  Future<bool> clearAuthToken();
  Future<Data?> getCachedAuthUser();
  Future<bool> cachedUserAuth(Data userAuthData);
}

class AuthLocalSourceImpl extends AuthLocalSource {
  @override
  Future<bool> cachedUserAuth(Data userAuthData) async{
    return await CacheManager.instance.storePref(userKey, userAuthData.toJson);
  }

  @override
  Future<bool> clearAuthToken() async {
    await CacheManager.instance.storePref(userKey, '');
    await CacheManager.instance.storePref(userTokenKey, '');
    return true;
  }

  @override
  Future<Data?> getCachedAuthUser() async {

    final authString =
        await CacheManager.instance.getPref(userKey) as String?;
    if (authString != null && authString.isNotEmpty) {
      pp('Local storage is not empty');
      return Data.fromJsonObject(authString);
    }
    pp('Local storage is empty');
    return null;
  }


}

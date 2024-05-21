import 'dart:convert';
import 'dart:io';

import 'package:parish_aid_admin/core/api/api_base.dart';
import 'package:parish_aid_admin/core/cache_manager/cache_manager.dart';
import 'package:parish_aid_admin/core/utils/strings.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';

import '../../features/auth/domain/entities/auth_user.dart';

Future<Map<String, String>> getHeaders(
    {bool? jsonRequest, bool tokenized = true}) async {
  if (jsonRequest != null && jsonRequest) {
    return {
      'Content-type': 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer ${(await getAuthUser())!.response!.data!.token}',
      'Accept': 'application/json'
    };
  } else if (!tokenized) {
    return {'Accept': 'application/json', 'api_key': appApiKey!};
  }

  final tokenizedHeader = {
    HttpHeaders.authorizationHeader:
        'Bearer ${(await getAuthUser())!.response!.data!.token}',
    'Accept': 'application/json',
    'api_key': appApiKey!
  };

  return tokenizedHeader;
}

Future<AuthUser?> getAuthUser() async {
  print(
      "The token from local db is ${CacheManager.instance.getPref(jsonDecode(userTokenKey))}");
  return AuthUserModel.fromJson(
      (await CacheManager.instance.getPref(userTokenKey)));
}

Future<AuthUser?> getUser() async {
  return AuthUserModel.fromJson(await CacheManager.instance.getPref(userKey));
}

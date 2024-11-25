import 'dart:convert';
import 'dart:io';

import 'package:parish_aid_admin/core/api/api_base.dart';
import 'package:parish_aid_admin/core/cache_manager/cache_manager.dart';
import 'package:parish_aid_admin/core/utils/strings.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';

Future<Map<String, String>> getHeaders(
    {bool? jsonRequest, bool tokenized = true}) async {
  if (jsonRequest != null && jsonRequest) {
    return {
      'Content-type': 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer ${(await getAuthUser())!.token}',
      'Accept': 'application/json'
    };
  } else if (!tokenized) {
    return {'Accept': 'application/json', 'api_key': appApiKey!};
  }

  final tokenizedHeader = {
    HttpHeaders.authorizationHeader:
        'Bearer ${(await getAuthUser())!.token}',
    'Accept': 'application/json',
    'api_key': appApiKey!
  };

  return tokenizedHeader;
}

Future<Data?> getAuthUser() async {
  return Data.fromJsonObject(
      (await CacheManager.instance.getPref(userKey)));
}

Future<Data?> getUser() async {
  return Data.fromJson(await CacheManager.instance.getPref(userKey));
}

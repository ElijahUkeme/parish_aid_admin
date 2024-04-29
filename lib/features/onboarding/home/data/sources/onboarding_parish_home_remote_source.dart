import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/onboarding/home/domain/usecases/get_onboarding_parish_by_uid.dart';

import '../../../../../api/api_client.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/json_checker/json_checker.dart';
import '../../../../../core/utils/strings.dart';

abstract class OnboardingParishHomeRemoteSource {
  Future<ParishModel> getOnboardingParish();
  Future<ParishModel> getOnboardingParishByUid(
      GetOnboardingParishByUidParams params);
}

class OnboardingParishHomeRemoteSourceImpl
    extends OnboardingParishHomeRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  OnboardingParishHomeRemoteSourceImpl(
      {required this.client, required this.jsonChecker});

  @override
  Future<ParishModel> getOnboardingParish() async {
    final response = await client
        .get(Uri.parse(onboardingParishGetEndPoint), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return ParishModel.fromJson(data);
      } else if (data['response']['code'] == unsupportedAccessErrorCode) {
        throw ServerException(data['response']['message']);
      } else {
        throw ServerException(serverErrorMsg);
      }
    } else {
      throw const FormatException('Invalid response');
    }
  }

  @override
  Future<ParishModel> getOnboardingParishByUid(
      GetOnboardingParishByUidParams params) async {
    String parishGet = '$getParishByUuidEndPoint?parish=${params.uuid}';

    final response = await client
        .get(Uri.parse(parishGet), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return ParishModel.fromJson(data);
      } else if (data['response']['code'] == unsupportedAccessErrorCode) {
        throw ServerException(data['response']['message']);
      } else {
        throw ServerException(serverErrorMsg);
      }
    } else {
      throw const FormatException('Invalid response');
    }
  }
}

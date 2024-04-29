import 'dart:convert';

import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/features/lga/domain/usecases/get_lga.dart';

import '../../../../api/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/json_checker/json_checker.dart';
import '../../../../core/utils/strings.dart';
import '../models/lga_model.dart';
import 'package:http/http.dart' as http;

abstract class LgaRemoteSource {
  Future<LgaModel> getLga(GetLgaParams params);
}

class LgaRemoteSourceImpl extends LgaRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  LgaRemoteSourceImpl({required this.client, required this.jsonChecker});

  @override
  Future<LgaModel> getLga(GetLgaParams params) async {
    String lgaGet =
        '$getLgaEndPoint?country_id=${params.countryId}&state_id=${params.stateId}';

    final response = await client
        .get(Uri.parse(lgaGet), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return LgaModel.fromJson(data);
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

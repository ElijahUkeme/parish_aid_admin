import 'dart:convert';

import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/features/diocese/domain/usecases/show_diocese.dart';

import '../../../../api/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/json_checker/json_checker.dart';
import '../../../../core/utils/strings.dart';
import '../models/diocese_model.dart';
import 'package:http/http.dart' as http;

abstract class DioceseRemoteSource {
  Future<DioceseModel> getDioceses();
  Future<DioceseModel> showDiocese(ShowDioceseParams params);
}

class DioceseRemoteSourceImpl extends DioceseRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  DioceseRemoteSourceImpl({required this.client, required this.jsonChecker});

  @override
  Future<DioceseModel> getDioceses() async {
    final response = await client
        .get(Uri.parse(dioceseListEndPoint), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {

        pp(data);

        return DioceseModel.fromJson(data);
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
  Future<DioceseModel> showDiocese(ShowDioceseParams params) async {
    String queriedDiocese =
        '$dioceseGetShowEndPoint?diocese_id=${params.dioceseId}';

    final response = await client
        .get(Uri.parse(queriedDiocese), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {

        pp(data);

        return DioceseModel.fromJson(data);
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

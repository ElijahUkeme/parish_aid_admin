import 'dart:convert';

import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/features/town/domain/usecases/get_town.dart';

import '../../../../api/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/json_checker/json_checker.dart';
import '../../../../core/utils/strings.dart';
import '../models/town_model.dart';
import 'package:http/http.dart' as http;

abstract class TownRemoteSource {
  Future<TownModel> getTown(GetTownParams params);
}

class TownRemoteSourceImpl extends TownRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  TownRemoteSourceImpl({required this.client, required this.jsonChecker});

  @override
  Future<TownModel> getTown(GetTownParams params) async {
    String townGet =
        '$getTownEndPoint?search=${params.searchKey}&country_id=${params.countryId}&state_id=${params.stateId}&lga_id=${params.lgaId}';

    final response = await client
        .get(Uri.parse(townGet), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {

        pp(data);

        return TownModel.fromJson(data);
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

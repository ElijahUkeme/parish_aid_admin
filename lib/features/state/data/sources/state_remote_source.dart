import 'dart:convert';

import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/features/state/domain/usecases/get_state.dart';

import '../../../../api/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/json_checker/json_checker.dart';
import '../../../../core/utils/strings.dart';
import '../models/state_model.dart';
import 'package:http/http.dart' as http;

abstract class StateRemoteSource{
  Future<StateModel> getState(GetStatesParams params);
}
class StateRemoteSourceImpl extends StateRemoteSource{
  final http.Client client;
  final JsonChecker jsonChecker;

  StateRemoteSourceImpl({required this.client,required this.jsonChecker});

  @override
  Future<StateModel> getState(GetStatesParams params) async {

    String stateGet = '$getStateEndPoint?country_id=${params.countryId}';

    final response = await client
        .get(Uri.parse(stateGet), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);

    return StateModel.fromJson(data);
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

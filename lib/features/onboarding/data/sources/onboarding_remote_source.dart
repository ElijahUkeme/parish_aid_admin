import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/features/onboarding/domain/usecases/register_parish.dart';

import '../../../../api/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/json_checker/json_checker.dart';
import '../../../../core/utils/strings.dart';
import '../../../home/data/model/parish_model.dart';

abstract class OnboardingRemoteSource {
  Future<ParishModel> registerParish(RegisterParishParams params);
}

class OnboardingRemoteSourceImpl extends OnboardingRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  OnboardingRemoteSourceImpl({required this.client, required this.jsonChecker});

  @override
  Future<ParishModel> registerParish(RegisterParishParams params) async {
    dynamic dioceseId = params.dioceseId;
    dynamic stateId = params.stateId;
    dynamic lgaId = params.lgaId;
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(registerParishEndPoint),
    )..headers.addAll(ApiClient.header);

    if (params.name != null && params.name!.isNotEmpty) {
      request.fields.addAll({'name': params.name!});
    }
    if (params.acronym != null && params.acronym!.isNotEmpty) {
      request.fields.addAll({'acronym': params.acronym!});
    }
    if (params.email != null && params.email!.isNotEmpty) {
      request.fields.addAll({'email': params.email!});
    }
    if (params.phoneNo != null && params.phoneNo!.isNotEmpty) {
      request.fields.addAll({'phone_no': params.phoneNo!});
    }
    if (params.address != null && params.address!.isNotEmpty) {
      request.fields.addAll({'address': params.address!});
    }
    if (params.dioceseId != null) {
      request.fields.addAll({'diocese_id': dioceseId});
    }
    if (params.stateId != null) {
      request.fields.addAll({'state_id': stateId});
    }
    if (params.lgaId != null) {
      request.fields.addAll({'lga_id': lgaId});
    }
    if (params.town != null && params.town!.isNotEmpty) {
      request.fields.addAll({'town': params.town!});
    }
    if (params.parishPriestName != null &&
        params.parishPriestName!.isNotEmpty) {
      request.fields.addAll({'parish_priest_name': params.parishPriestName!});
    }
    if (params.password != null && params.password!.isNotEmpty) {
      request.fields.addAll({'password': params.password!});
    }
    if (params.registrarEmail != null && params.registrarEmail!.isNotEmpty) {
      request.fields.addAll({'registrar_email': params.registrarEmail!});
    }
    if (params.logo != null && params.logo!.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath('logo', params.logo!));
    }
    if (params.coverImage != null && params.coverImage!.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('cover_image', params.coverImage!));
    }

    //send a request and return a streamedResponse object
    final streamedResponse =
        await request.send().timeout(const Duration(seconds: 50));

    final response = await http.Response.fromStream(streamedResponse);

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);

      if (data['status' == 'OK']) {
        print("the returned response is ${ParishModel.fromJson(data)}");
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

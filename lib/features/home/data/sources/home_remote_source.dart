import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:parish_aid_admin/api/api_client.dart';
import 'package:parish_aid_admin/core/api/api_auth.dart';
import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/core/errors/exceptions.dart';
import 'package:parish_aid_admin/core/json_checker/json_checker.dart';
import 'package:parish_aid_admin/core/utils/strings.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:http/http.dart' as http;
import 'package:parish_aid_admin/features/home/domain/usecases/approve_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/create_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/delete_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_show.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/update_parish.dart';

abstract class HomeRemoteSource {
  Future<ParishModel> getParishes();
  Future<ParishModel> getShow(GetShowParam param);
  Future<ParishModel> updateParish(UpdateParishParams params);
  Future<ParishModel> createParish(CreateParishParams params);
  Future<ParishModel> approveParish(ApproveParishParam param);
  Future<bool> deleteParish(DeleteParishParam param);
}

class HomeRemoteSourceImpl extends HomeRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  HomeRemoteSourceImpl({required this.client, required this.jsonChecker});

  @override
  Future<ParishModel> getParishes() async {
    final response = await client
        .get(Uri.parse(parishListEndPoint), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      //print("The response is $data");
      //print("The response status is ${data['status']}");
      if (data['status'] == 'OK') {
        final ParishModel parishes = ParishModel.fromJson(data);

        // for (final parish in parishes.response!.data!) {
        //   print(parish.parishPriestName);
        // }
        print("The list contains ${parishes.response!.data}");
        print("the whole response is ${parishes.toString()}");
        return parishes;
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
  Future<ParishModel> getShow(GetShowParam param) async {
    String showGet = '$getShowEnPoint?parish=${param.parish}';

    final response = await client
        .get(Uri.parse(showGet), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      print("The response is $data");
      if (data['status'] == 'OK') {
        print("The get show response returns $data");
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
  Future<ParishModel> updateParish(UpdateParishParams params) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$updateParishEndPoint?parish=${params.parishId}'),
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
      request.fields.addAll({'diocese_id': params.dioceseId.toString()});
    }
    if (params.stateId != null) {
      request.fields.addAll({'state_id': params.stateId.toString()});
    }
    if (params.lgaId != null) {
      request.fields.addAll({'lga_id': params.lgaId.toString()});
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
      print("The update response is $data");
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

  @override
  Future<ParishModel> createParish(CreateParishParams params) async {
    dynamic dioceseId = params.dioceseId;
    dynamic stateId = params.stateId;
    dynamic lgaId = params.lgaId;
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(createParishEndPoint),
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

    print("The response is ${response.body}");

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);
      print("The response body is $data");
      if (data['status'] == "OK") {
        print("the returned response is ${ParishModel.fromJson(data)}");
        return ParishModel.fromJson(data);
      } else if (data['response']['code'] == unsupportedAccessErrorCode) {
        throw ServerException(data['response']['message']);
      } else {
        throw ServerException(serverErrorMsg);
      }
    } else {
      print(response.body);
      throw const FormatException('Invalid response');
    }
  }

  @override
  Future<ParishModel> approveParish(ApproveParishParam param) async {
    String approveParish = '$approveParishEndPoint?parish=${param.parish}';

    final response = await client
        .post(Uri.parse(approveParish), headers: ApiClient.header)
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
  Future<bool> deleteParish(DeleteParishParam param) async {
    String deleteParish = '$deleteParishEndPoint?parish=${param.parish}';

    final response = await client
        .delete(Uri.parse(deleteParish), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return true;
      } else {
        throw ServerException(data['response']['message']);
      }
    } else {
      throw const FormatException();
    }
  }
}

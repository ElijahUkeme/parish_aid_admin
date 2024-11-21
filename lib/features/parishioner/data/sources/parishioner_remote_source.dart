import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/create_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/delete_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/get_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/get_parishioners.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/update_parishioner.dart';

import '../../../../api/api_client.dart';
import '../../../../core/api/api_auth.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/json_checker/json_checker.dart';
import '../../../../core/utils/strings.dart';
import '../model/parishioner_list_model.dart';
import '../model/parishioner_model.dart';

abstract class ParishionerRemoteSource {
  Future<ParishionerModel> createParishioner(CreateParishionerParams params);

  Future<ParishionerModel> updateParishioner(UpdateParishionerParams params);

  Future<ParishionerListModel> getParishioners(GetParishionersParam param);
  Future<ParishionerModel> getParishioner(GetParishionerParams params);
  Future<bool> deleteParishioner(DeleteParishionerParams params);

}

class ParishionerRemoteSourceImpl extends ParishionerRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  ParishionerRemoteSourceImpl(
      {required this.client, required this.jsonChecker});

  @override
  Future<ParishionerModel> createParishioner(
      CreateParishionerParams params) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$createParishionerEndPoint/parish=${params
          .parishId}/parishioners/create'),
    )
      ..headers.addAll(await getHeaders());

    if (params.name != null && params.name!.isNotEmpty) {
      request.fields.addAll({'name': params.name!});
    }
    if (params.email != null && params.email!.isNotEmpty) {
      request.fields.addAll({'email': params.email!});
    }
    if (params.phoneNo != null && params.phoneNo!.isNotEmpty) {
      request.fields.addAll({'phone_no': params.phoneNo!});
    }
    if (params.gender != null && params.gender!.isNotEmpty) {
      request.fields.addAll({'gender': params.gender!});
    }
    if (params.whatsAppNo != null && params.whatsAppNo!.isNotEmpty) {
      request.fields.addAll({'whatsapp_no': params.whatsAppNo!});
    }
    if (params.dob != null && params.dob!.isNotEmpty) {
      request.fields.addAll({'dob': params.dob!});
    }
    if (params.employmentStatus != null &&
        params.employmentStatus!.isNotEmpty) {
      request.fields.addAll({'employment_status': params.employmentStatus!});
    }
    if (params.address != null && params.address!.isNotEmpty) {
      request.fields.addAll({'address': params.address!});
    }
    if (params.employerName != null && params.employerName!.isNotEmpty) {
      request.fields.addAll({'employer_name': params.employerName!});
    }
    if (params.school != null && params.school!.isNotEmpty) {
      request.fields.addAll({'school_name': params.school!});
    }
    if (params.stateId != null ) {
      request.fields.addAll({'state_id': params.stateId!.toString()});
    }
    if (params.lgaId != null) {
      request.fields.addAll({'lga_id': params.lgaId!.toString()});
    }
    if (params.parishId != null && params.parishId!.isNotEmpty) {
      request.fields.addAll({'parish_id': params.parishId!});
    }
    if (params.groupId != null && params.groupId!.isNotEmpty) {
      request.fields.addAll({'group_id': params.groupId!});
    }
    if (params.town != null && params.town!.isNotEmpty) {
      request.fields.addAll({'town': params.town!});
    }

    if (params.image != null && params.image!.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('image', params.image!));
    }

    //send a request and return a streamedResponse object
    final streamedResponse =
    await request.send().timeout(const Duration(seconds: 50));

    final response = await http.Response.fromStream(streamedResponse);

    pp(response.body);

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);


      if (data['status'] == "OK") {

        pp(data);

        return ParishionerModel.fromJson(data);
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
  Future<ParishionerModel> updateParishioner(
      UpdateParishionerParams params) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$updateParishionerEndPoint/${params
          .parishId}/parishioners/update/${params.parishioner}'),
    )
      ..headers.addAll(await getHeaders());

    if (params.name != null && params.name!.isNotEmpty) {
      request.fields.addAll({'name': params.name!});
    }
    if (params.email != null && params.email!.isNotEmpty) {
      request.fields.addAll({'email': params.email!});
    }
    if (params.phoneNo != null && params.phoneNo!.isNotEmpty) {
      request.fields.addAll({'phone_no': params.phoneNo!});
    }
    if (params.gender != null && params.gender!.isNotEmpty) {
      request.fields.addAll({'gender': params.gender!});
    }
    if (params.whatsAppNo != null && params.whatsAppNo!.isNotEmpty) {
      request.fields.addAll({'whatsapp_no': params.whatsAppNo!});
    }
    if (params.dob != null && params.dob!.isNotEmpty) {
      request.fields.addAll({'dob': params.dob!});
    }
    if (params.employmentStatus != null &&
        params.employmentStatus!.isNotEmpty) {
      request.fields.addAll({'employment_status': params.employmentStatus!});
    }
    if (params.address != null && params.address!.isNotEmpty) {
      request.fields.addAll({'address': params.address!});
    }
    if (params.employerName != null && params.employerName!.isNotEmpty) {
      request.fields.addAll({'employer_name': params.employerName!});
    }
    if (params.school != null && params.school!.isNotEmpty) {
      request.fields.addAll({'school': params.school!});
    }
    if (params.stateId != null && params.stateId!.isNotEmpty) {
      request.fields.addAll({'state_id': params.stateId!});
    }
    if (params.lgaId != null && params.lgaId!.isNotEmpty) {
      request.fields.addAll({'lga_id': params.lgaId!});
    }
    if (params.parishId != null && params.parishId!.isNotEmpty) {
      request.fields.addAll({'parish_id': params.parishId!});
    }
    if (params.parishioner != null && params.parishioner!.isNotEmpty) {
      request.fields.addAll({'parishioner': params.parishioner!});
    }
    if (params.groupId != null && params.groupId!.isNotEmpty) {
      request.fields.addAll({'group_id': params.groupId!});
    }
    if (params.town != null && params.town!.isNotEmpty) {
      request.fields.addAll({'town': params.town!});
    }

    if (params.image != null && params.image!.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('image', params.image!));
    }

    //send a request and return a streamedResponse object
    final streamedResponse =
    await request.send().timeout(const Duration(seconds: 50));

    final response = await http.Response.fromStream(streamedResponse);

    pp(response.body);

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);


      if (data['status'] == "OK") {

        pp(data);

        return ParishionerModel.fromJson(data);
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
  Future<ParishionerListModel> getParishioners(
      GetParishionersParam param) async {
    final response = await client
        .get(Uri.parse('$getParishionersEndPoint/${param.parish}/parishioners'),
        headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {

        pp(data);

        ParishionerListModel parishionerListModel = ParishionerListModel
            .fromJson(data);


        return parishionerListModel;
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
  Future<ParishionerModel> getParishioner(GetParishionerParams params) async {

    String parishionerGet = '$getParishionerEndPoint/${params.parish}/parishioners/show/${params.parishioner}';
    final response = await client
        .get(Uri.parse(parishionerGet), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);
    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);

    return ParishionerModel.fromJson(data);
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
  Future<bool> deleteParishioner(DeleteParishionerParams params) async {
    String deleteGroup = '$deleteParishionerEndPoint/${params.parish}/parishioners/destroy/${params.parishioner}';

    final response = await client
        .delete(Uri.parse(deleteGroup), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

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

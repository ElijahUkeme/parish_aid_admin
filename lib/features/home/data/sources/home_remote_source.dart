import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parish_aid_admin/api/api_client.dart';
import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/core/errors/exceptions.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/core/json_checker/json_checker.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/core/utils/strings.dart';
import 'package:parish_aid_admin/features/home/data/model/get_parish_model.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/approve_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/create_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/create_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/delete_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/delete_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_verification_code_list.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_verification_code_stat.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/print_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/show_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/update_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/update_verification_code.dart';

import '../../../../core/api/api_auth.dart';
import '../model/print_verification_code_model.dart';
import '../model/verification_code_model.dart';
import '../model/verification_code_stat_model.dart';

abstract class HomeRemoteSource {
  Future<ParishModel> getParishes();
  Future<GetParishModel> getParish(GetParishParam param);
  Future<GetParishModel> updateParish(UpdateParishParams params);
  Future<ParishModel> createParish(CreateParishParams params);
  Future<GetParishModel> approveParish(ApproveParishParam param);
  Future<bool> deleteParish(DeleteParishParam param);
  Future<VerificationCodeModel>createVerificationCode(CreateVerificationCodeParams params);
  Future<VerificationCodeModel> updateVerificationCode(UpdateVerificationCodeParams params);
  Future<PrintVerificationCodeModel> printVerification(PrintVerificationCodeParams params);
  Future<VerificationCodeModel> getVerificationCodeList(GetVerificationCodeListParam param);
  Future<VerificationCodeStatModel> getVerificationCodeStat(GetVerificationCodeStatParam param);
  Future<VerificationCodeData> showVerificationCode(ShowVerificationCodeParam params);
  Future<bool> deleteVerificationCode(DeleteVerificationCodeParams params);
}

class HomeRemoteSourceImpl extends HomeRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  HomeRemoteSourceImpl({required this.client, required this.jsonChecker});

  @override
  Future<ParishModel> getParishes() async {
    final response = await client
        .get(Uri.parse(parishListEndPoint), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final ParishModel parishes = ParishModel.fromJson(data);
        pp(data);
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
  Future<GetParishModel> getParish(GetParishParam param) async {
    String parishGet = '$getShowEnPoint/${param.parish}';

    final response = await client
        .get(Uri.parse(parishGet), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {

        pp(data);

        return GetParishModel.fromJson(data);
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
  Future<GetParishModel> updateParish(UpdateParishParams params) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$updateParishEndPoint/${params.parishId}'),
    )..headers.addAll(await getHeaders());

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

    pp(response.body);

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);

      if (data['status']=='OK') {

        pp(data);

        return GetParishModel.fromJson(data);
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
    )..headers.addAll(await getHeaders());

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

    pp(response.body);

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);

      pp(data);

      if (data['status'] == "OK") {

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
  Future<GetParishModel> approveParish(ApproveParishParam param) async {
    String approveParish = '$approveParishEndPoint/${param.parish}';

    final response = await client
        .post(Uri.parse(approveParish), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);

      pp(data);

      if (data['status'] == 'OK') {

        return GetParishModel.fromJson(data);
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
    String deleteParish = '$deleteParishEndPoint/${param.parish}';

    final response = await client
        .delete(Uri.parse(deleteParish), headers: await getHeaders())
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

  @override
  Future<VerificationCodeModel> createVerificationCode(CreateVerificationCodeParams params) async {
    String createVCode = '$createVerificationCodeEndPoint/${params.parishId}/verification-codes/create';

    final body = {
      'parish_id':params.parishId.toString(),
      'quantity':params.quantity.toString(),
      'expires_at':params.expiresAt
    };

    final response = await client
        .post(Uri.parse(createVCode),body: body, headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);


    if (data['status'] == 'OK') {

    return VerificationCodeModel.fromJson(data);
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
  Future<VerificationCodeModel> updateVerificationCode(UpdateVerificationCodeParams params) async {

    String updateVCode = '$updateVerificationCodeEndPoint/${params.parishId}/verification-codes/update/${params.vCodeId}';
    
    final body = {};
    
    if(!params.expiresAt.isEmptyOrNull){
      body.addAll({'expires_at':params.expiresAt});
    }
    if(!params.status.isEmptyOrNull){
      body.addAll({'status':params.status});
    }
    if(params.printStatus !=null){
      body.addAll({'print_status':params.printStatus});
    }

    final response = await client
        .post(Uri.parse(updateVCode),body: json.encode(body), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);


    if (data['status'] == 'OK') {

    return VerificationCodeModel.fromJson(data);
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
  Future<PrintVerificationCodeModel> printVerification(PrintVerificationCodeParams params) async {

    String printVCode = '$printVerificationCodeEndPoint/${params.parishId}/verification-codes/print';

    final response = await client
        .post(Uri.parse(printVCode), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);


    if (data['status'] == 'OK') {

      pp(data);
    return PrintVerificationCodeModel.fromJson(data);
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
  Future<VerificationCodeModel> getVerificationCodeList(GetVerificationCodeListParam param) async {

    String vCodeList = '$verificationCodeListEndPoint/${param.parish}/verification-codes';

    final response = await client
        .get(Uri.parse(vCodeList), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));


    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {

    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);
      VerificationCodeModel verificationCode = VerificationCodeModel.fromJson(data);

    return verificationCode;
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
  Future<VerificationCodeStatModel> getVerificationCodeStat(GetVerificationCodeStatParam param) async {

    String vCodeStat = '$getStatsEndPoint/${param.parish}/verification-codes/stats';

    final response = await client
        .get(Uri.parse(vCodeStat), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {

    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);

    return VerificationCodeStatModel.fromJson(data);
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
  Future<VerificationCodeData> showVerificationCode(ShowVerificationCodeParam params) async {
    String vCodeShow = '$showVerificationCodeEndPoint/${params.parish}/verification-codes/show/${params.code}';

    final response = await client
        .get(Uri.parse(vCodeShow), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {

    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);
    return VerificationCodeData.fromJson(data['response']['data']);
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
  Future<bool> deleteVerificationCode(DeleteVerificationCodeParams params) async {
    String deleteVCode = '$deleteVerificationCodeEndPoint/${params.parish}/verification-codes/destroy/${params.code}';

    final response = await client
        .delete(Uri.parse(deleteVCode), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);
    if (data['status'] == 'OK') {
      pp(data);
    return true;
    } else {
    throw ServerException(data['response']['message']);
    }
    } else {
    throw const FormatException();
    }
  }
}

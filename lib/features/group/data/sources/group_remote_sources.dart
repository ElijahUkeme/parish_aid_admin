import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/features/group/data/model/get_group_model.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/create_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/create_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/delete_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/delete_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_group_admins.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_groups.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/show_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/update_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/update_group_admin.dart';

import '../../../../core/api/api_auth.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/json_checker/json_checker.dart';
import '../../../../core/utils/strings.dart';
import '../model/group_admin_model.dart';

abstract class GroupRemoteSource{

  Future<GetGroupModel> createGroup(CreateGroupParams params);
  Future<GetGroupModel> updateGroup(UpdateGroupParams params);
  Future<GetGroupModel> getGroup(GetGroupParams params);
  Future<GroupModel> getGroups(GetGroupsParams params);
  Future<bool> deleteGroup(DeleteGroupParams params);
  Future<GroupAdminModel> updateGroupAdmin(UpdateGroupAdminParam params);
  Future<List<GroupAdminData>> getGroupAdmins(GetGroupAdminsParams params);
  Future<GroupAdminModel> showGroupAdmin(ShowGroupAdminParams params);
  Future<bool> deleteGroupAdmin(DeleteGroupAdminParams params);
  Future<GroupAdminModel> createGroupAdmin(CreateGroupAdminParams params);

}
class GroupRemoteSourceImpl extends GroupRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  GroupRemoteSourceImpl({required this.client, required this.jsonChecker});

  @override
  Future<GetGroupModel> createGroup(CreateGroupParams params) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$createGroupEndPoint/parish=${params.parishId}/groups/create'),
    )
      ..headers.addAll(await getHeaders());

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
    if (params.stateId != null) {
      request.fields.addAll({'state_id': params.stateId!.toString()});
    }
    if (params.parishId != null && params.parishId!.isNotEmpty) {
      request.fields.addAll({"parish_id": params.parishId!});
    }
    if (params.lgaId != null ) {
      request.fields.addAll({'lga_id': params.lgaId!.toString()});
    }
    if (params.town != null && params.town!.isNotEmpty) {
      request.fields.addAll({'town': params.town!});
    }
    if (params.password != null && params.password!.isNotEmpty) {
      request.fields.addAll({'password': params.password!});
    }
    if (params.registrarEmail != null && params.registrarEmail!.isNotEmpty) {
      request.fields.addAll({'registrar_email': params.registrarEmail!});
    }
    if (params.category != null && params.category!.isNotEmpty) {
      request.fields.addAll({'category': params.category!});
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

      if (data['status'] == "OK") {

        pp(data);
        return GetGroupModel.fromJson(data);
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
  Future<GetGroupModel> updateGroup(UpdateGroupParams params) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
          '$updateGroupEndPoint/parish/${params.parishId}/groups/update/${params
              .groupId}'),
    )
      ..headers.addAll(await getHeaders());

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
    if (params.stateId != null && params.stateId!.isNotEmpty) {
      request.fields.addAll({'state_id': params.stateId!});
    }
    if (params.parishId != null && params.parishId!.isNotEmpty) {
      request.fields.addAll({"parish_id": params.parishId!});
    }
    if (params.lgaId != null && params.lgaId!.isNotEmpty) {
      request.fields.addAll({'lga_id': params.lgaId!});
    }
    if (params.town != null && params.town!.isNotEmpty) {
      request.fields.addAll({'town': params.town!});
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

      if (data['status'] == "OK") {

        pp(data);

        return GetGroupModel.fromJson(data);
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
  Future<GetGroupModel> getGroup(GetGroupParams params) async {
    String groupGet = '$getGroupEndPoint/${params.parishId}/groups/show/${params
        .groupId}';
    final response = await client
        .get(Uri.parse(groupGet), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {

        pp(data);

        return GetGroupModel.fromJson(data);
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
  Future<GroupModel> getGroups(GetGroupsParams params) async {
    final response = await client
        .get(Uri.parse('$getGroupsEndPoint/${params.parish}/groups'),
        headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {

        pp(data);

        final GroupModel groupModel = GroupModel.fromJson(data);


        return groupModel;
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
  Future<bool> deleteGroup(DeleteGroupParams params) async {

    String deleteGroup = '$deleteGroupEndPoint/${params.parishId}/groups/destroy/${params.groupId}';

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

  @override
  Future<GroupAdminModel> updateGroupAdmin(UpdateGroupAdminParam params) async {

    String updateGroupAdmin = '$updateGroupAdminEndPoint/${params.parish}/groups/${params.group}/admins/update/${params.admin}';


    final body = {
      'email':params.email,
      'name':params.name,
      'role':params.role,
      'group_id':params.groupId.toString()
    };

    final response = await client
        .post(Uri.parse(updateGroupAdmin),
        body: json.encode(body), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(body);

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {

        pp(data);

        //parse the json response to dart object
        return GroupAdminModel.fromJson(data);
      } else if (data['response']['code'] == 461) {
        throw ServerException(data['response']['message']);
      } else if (data['response']['code'] == 422) {
        throw ServerException(data['response']['message']);
      } else {
        throw ServerException(data['response']['message']);
      }
    } else {
      throw const FormatException();
    }
  }

  @override
  Future<List<GroupAdminData>> getGroupAdmins(GetGroupAdminsParams params) async {
    String getGroupAdmins = '$getGroupAdminsEndPoint/${params.parish}/groups/${params.group}/admins';

    final response = await client
        .get(Uri.parse(getGroupAdmins),
         headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);
      final List<dynamic> groupAdmins = data['response']['data'];

      final List<GroupAdminData> groupList = groupAdmins
          .map((item) => GroupAdminData.fromJson(item))
          .toList();

      for(final admin in groupList){
        pp(admin.user!.email);
        pp(admin.user!.firstName);
      }

    return groupList;
    } else if (data['response']['code'] == 461) {
    throw ServerException(data['response']['message']);
    } else if (data['response']['code'] == 422) {
    throw ServerException(data['response']['message']);
    } else {
    throw ServerException(data['response']['message']);
    }
    } else {
    throw const FormatException();
    }
  }

  @override
  Future<GroupAdminModel> showGroupAdmin(ShowGroupAdminParams params) async {

    String showGroupAdmin = '$showGroupAdminEndPoint/${params.parish}/groups/${params.group}/admins/show/${params.admin}';

    final response = await client
        .get(Uri.parse(showGroupAdmin), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);

    //parse the json response to dart object
    return GroupAdminModel.fromJson(data);
    } else if (data['response']['code'] == 461) {
    throw ServerException(data['response']['message']);
    } else if (data['response']['code'] == 422) {
    throw ServerException(data['response']['message']);
    } else {
    throw ServerException(data['response']['message']);
    }
    } else {
    throw const FormatException();
    }
  }

  @override
  Future<bool> deleteGroupAdmin(DeleteGroupAdminParams params) async {

    String deleteGroupAdmin = '$showGroupAdminEndPoint/${params.parish}/groups/${params.group}/admins/destroy/${params.admin}';

    final response = await client
        .delete(Uri.parse(deleteGroupAdmin), headers: await getHeaders())
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
  Future<GroupAdminModel> createGroupAdmin(CreateGroupAdminParams params) async {
    String createGroupAdmin = '$createGroupEndPoint/parish=${params.parish}/groups/${params.group}/admins/create';
    final body = {};

    if(params.email !=null && params.email!.isNotEmpty){
      body.addAll({'email':params.email});
    }
    if(params.name !=null && params.name!.isNotEmpty){
      body.addAll({'name':params.name});
    }
    if(params.role !=null && params.role!.isNotEmpty){
      body.addAll({'role':params.role});
    }
    if(params.group !=null){
      body.addAll({'group_id':params.group});
    }

    final response = await client
        .post(Uri.parse(createGroupAdmin),
        body: json.encode(body), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);

    //parse the json response to dart object
    return GroupAdminModel.fromJson(data);
    } else if (data['response']['code'] == 461) {
    throw ServerException(data['response']['message']);
    } else if (data['response']['code'] == 422) {
    throw ServerException(data['response']['message']);
    } else {
    throw ServerException(data['response']['message']);
    }
    } else {
    throw const FormatException();
    }
  }
}
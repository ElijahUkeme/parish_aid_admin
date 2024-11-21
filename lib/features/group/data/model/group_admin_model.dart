import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';

import '../../../auth/data/models/auth_user_model.dart';

class GroupAdminModel{
  final String? terminus;
  final String? status;
  final GroupAdminResponse? response;

  GroupAdminModel({this.terminus,this.status,this.response});

  factory GroupAdminModel.fromJson(Map<String,dynamic>json)=>
      GroupAdminModel(terminus: json['terminus'],
      status: json['status'],
      response: json['response']??'');
}

class GroupAdminResponse{
  int? code;
  String? title;
  String? message;
  GroupAdminData? data;

  GroupAdminResponse(this.code,this.title,this.message,this.data);
  GroupAdminResponse.fromJson(Map<String,dynamic>json){
    code = json['code'];
    title = json['title'];
    message = json['message'];
    if(json['data']!=null){
      data = GroupAdminData.fromJson(json['data']);
    }
  }


}
class GroupAdminData{
  int? id;
  String? role;
  String? status;
  GroupData? group;
  UserResponse? user;

  GroupAdminData(this.id,this.role,this.status,this.group,this.user);

  GroupAdminData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    role = json['role'];
    status = json['status'];
    if(json['group'] !=null){
      group = GroupData.fromJson(json['group']);
    }
    if(json['user']!=null){
      user = UserResponse.fromJson(json['user']);
    }
  }
}
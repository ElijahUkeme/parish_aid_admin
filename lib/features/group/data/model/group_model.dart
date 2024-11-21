import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';

import '../../../auth/data/models/auth_user_model.dart';

class GroupModel {

  final String? terminus;
  final String? status;
  final GroupResponse? response;

  GroupModel({this.terminus, this.status, this.response});

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
      terminus: json["terminus"],
      status: json["status"],
      response: GroupResponse.fromJson(json["response"]));
}

class GroupResponse{

  int? code;
  String? title;
  String? message;
  List<GroupData>? data;

  GroupResponse(this.code, this.title, this.message, this.data);

  GroupResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    title = json["title"];
    message = json["message"];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((e){
        data!.add(GroupData.fromJson(e));
      });
    }
  }
}
class GroupData{
  int? id;
  String? name;
  String? uuid;
  String? email;
  String? acronym;
  String? category;
  String? status;
  String? phoneNo;
  String? type;
  Town? town;
  LgaDataModel? lga;
  State? state;
  Country? country;
  Attachments? attachments;
  Logo? logo;
  CoverImage? coverImage;
  UserResponse? user;

  GroupData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    acronym = json['acronym'];
    uuid = json['uuid'];
    phoneNo = json['phone_no'];
    if(json['category'] !=null){
      category = json['category'];
    }else{
      category = '';
    }
    status = json['status'];
    type = json['type'];
    email = json['email'];
    if (json['town'] != null) {
      town = Town.fromJson(json['town']);
    }
    if (json['state'] != null) {
      state = State.fromJson(json['state']);
    }
    if(json['lga'] !=null){
      lga = LgaDataModel.fromJson(json['lga']);
    }
    if (json['country'] != null) {
      country = Country.fromJson(json['country']);
    }

    if (json['attachments'] != null) {
      attachments = Attachments.fromJson(json['attachments']);
    }
    if(json['logo'] !=null){
      logo = Logo.fromJson(json['logo']);
    }
    if(json['coverImage'] !=null){
      coverImage = CoverImage.fromJson(json['coverImage']);
    }
    if(json['user'] !=null){
      user = UserResponse.fromJson(json['user']);
    }
  }
}
class LgaDataModel{
  int? id;
  String? name;

  LgaDataModel(this.id,this.name);

  LgaDataModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
  }
}
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';

class GetGroupModel{

  final String? terminus;
  final String? status;
  final GetGroupResponse? response;

  GetGroupModel({this.terminus, this.status, this.response});

  factory GetGroupModel.fromJson(Map<String, dynamic> json) => GetGroupModel(
      terminus: json["terminus"],
      status: json["status"],
      response: GetGroupResponse.fromJson(json['response']));
}
class GetGroupResponse{

  int? code;
  String? title;
  String? message;
  GroupData? data;

  GetGroupResponse(this.code, this.title, this.message, this.data);

  GetGroupResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    title = json["title"];
    message = json["message"];
    if (json['data'] != null) {
      data = GroupData.fromJson(json['data']);
    }
  }
}
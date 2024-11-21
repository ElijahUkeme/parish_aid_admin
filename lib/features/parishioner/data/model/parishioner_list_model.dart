import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_model.dart';

class ParishionerListModel{

  final String? terminus;
  final String? status;
  final ParishionerListResponse? response;

  ParishionerListModel({this.terminus, this.status, this.response});

  factory ParishionerListModel.fromJson(Map<String, dynamic> json) => ParishionerListModel(
      terminus: json["terminus"],
      status: json["status"],
      response: ParishionerListResponse.fromJson(json['response']));
}
class ParishionerListResponse {

  int? code;
  String? title;
  String? message;
  List<ParishionerData>? data;

  ParishionerListResponse(this.code, this.title, this.message, this.data);
  ParishionerListResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    title = json["title"];
    message = json["message"];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((e) {
        data!.add(ParishionerData.fromJson(e));
      });
    }
  }
}
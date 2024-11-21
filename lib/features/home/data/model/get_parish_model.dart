
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';

class GetParishModel{
  final String? terminus;
  final String? status;
  final GetParishResponse? response;

  GetParishModel({this.terminus, this.status, this.response});

  factory GetParishModel.fromJson(Map<String, dynamic> json) => GetParishModel(
  terminus: json["terminus"],
  status: json["status"],
  response: GetParishResponse.fromJson(json['response']));
}
class GetParishResponse{

  int? code;
  String? title;
  String? message;
  ParishData? data;

  GetParishResponse(this.code, this.title, this.message, this.data);

  GetParishResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    title = json["title"];
    message = json["message"];
    if (json['data'] != null) {
      data = ParishData.fromJson(json['data']);
    }
  }

}
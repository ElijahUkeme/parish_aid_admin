import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';

class ParishionerModel {

  final String? terminus;
  final String? status;
  final ParishionerResponse? response;

  ParishionerModel({this.terminus, this.status, this.response});

  factory ParishionerModel.fromJson(Map<String, dynamic> json) => ParishionerModel(
      terminus: json["terminus"],
      status: json["status"],
      response: ParishionerResponse.fromJson(json['response']));
}
class ParishionerResponse{

  int? code;
  String? title;
  String? message;
  ParishionerData? data;

  ParishionerResponse(this.code, this.title, this.message, this.data);

  ParishionerResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    title = json["title"];
    message = json["message"];
    if (json['data'] != null) {
      data = ParishionerData.fromJson(json['data']);
    }
  }
}
class ParishionerData{
  int? id;
  String? name;
  String? uuid;
  String? email;
  String? phoneNo;
  String? gender;
  String? whatsAppNo;
  String? dob;
  String? employmentStatus;
  String? status;
  String? address;
  String? employerName;
  String? school;
  String? image;
  ParishData? parish;

  ParishionerData(this.id,this.name,this.uuid,this.email,this.phoneNo,this.gender,this.whatsAppNo,this.dob,
      this.employmentStatus,this.status,this.address,this.employerName,this.school,this.image,this.parish);

  ParishionerData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    uuid = json['uuid'];
    email = json['email'];
    phoneNo = json['phone_no'];
    gender = json['gender'];
    whatsAppNo =  json['whatsapp_no'];
    dob = json['dob'];
    employmentStatus = json['employment_status'];
    status = json['status'];
    address = json['address'];
    employerName = json['employee_name'];
    school = json['school_name'];
    image = json['image'];
    parish = ParishData.fromJson(json['parish']);
  }

}
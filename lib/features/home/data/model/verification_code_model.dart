
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';

class VerificationCodeModel{
  final String? terminus;
  final String? status;
  final VerificationCodeResponse? response;

  VerificationCodeModel({this.terminus,this.status,this.response});

  factory VerificationCodeModel.fromJson(Map<String,dynamic>json)=>
      VerificationCodeModel(terminus: json['terminus'],status: json['status'],response: VerificationCodeResponse.fromJson(json['response']??''));
}
class VerificationCodeResponse{
 int? code;
 String? title;
 String? message;
 List<VerificationCodeData>? data;

 VerificationCodeResponse(this.code,this.title,this.message,this.data);

 VerificationCodeResponse.fromJson(Map<String,dynamic>json){
   code = json['code'];
   title = json['title'];
   message = json['message'];
   data = json['data'] !=null?
   (json['data']as List<dynamic>)
       .map((e)=>VerificationCodeData.fromJson(e)).toList():[];

 }

}
class VerificationCodeData{
  int? id;
  String? code;
  String? batchNo;
  String? tags;
  String? expiresAt;
  String? createdAt;
  ParishData? parish;

  VerificationCodeData(this.id,this.code,this.batchNo,this.tags,this.expiresAt,this.createdAt,this.parish);

  VerificationCodeData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    code = json['code'];
    batchNo = json['batch_no'];
    tags = json['tags']??'';
    expiresAt = json['expires_at'];
    createdAt = json['created_at'];
    parish = ParishData.fromJson(json['parish']??'');
  }
}
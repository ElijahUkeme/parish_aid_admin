class VerificationCodeStatModel{
  final String terminus;
  final String status;
  final VerificationCodeStatResponse response;

  VerificationCodeStatModel({required this.terminus,required this.status,required this.response});

  factory VerificationCodeStatModel.fromJson(Map<String,dynamic>json)=>
      VerificationCodeStatModel(terminus: json['terminus'], status: json['status'], response: VerificationCodeStatResponse.fromJson(json['response']??''));
}
class VerificationCodeStatResponse{
  int? code;
  String? title;
  String? message;
  List<VerificationCodeStatData>? data;

  VerificationCodeStatResponse(this.code,this.title,this.message,this.data);

  VerificationCodeStatResponse.fromJson(Map<String,dynamic>json){
    code = json['code'];
    title = json['title'];
    message = json['message'];
    data = json['data'] !=null?
    (json['data']as List<dynamic>).map((e)=>VerificationCodeStatData.fromJson(e)).toList():[];
  }
}
class VerificationCodeStatData{
  String? title;
  int? count;

  VerificationCodeStatData(this.title,this.count);

  VerificationCodeStatData.fromJson(Map<String,dynamic>json){
    title = json['title'];
    count = json['count'];
  }
}
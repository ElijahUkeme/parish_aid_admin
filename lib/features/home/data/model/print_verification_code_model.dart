class PrintVerificationCodeModel{
  final String? terminus;
  final String? status;
  final PrintVerificationCodeResponse? response;

  PrintVerificationCodeModel({this.terminus,this.status,this.response});

  factory PrintVerificationCodeModel.fromJson(Map<String,dynamic>json)=>
      PrintVerificationCodeModel(
          terminus: json['terminus'],
          status: json['status'],
          response: PrintVerificationCodeResponse.fromJson(json['response']??''));
}
class PrintVerificationCodeResponse{
  int? code;
  String? title;
  String? message;
  PrintVerificationCodeData? data;

  PrintVerificationCodeResponse(this.code,this.title,this.message,this.data);

  PrintVerificationCodeResponse.fromJson(Map<String,dynamic>json){
    code = json['code'];
    title = json['title'];
    message = json['message'];
   if(json['data'] !=null){
     data = PrintVerificationCodeData.fromJson(json['data']);
   }
  }
}
class PrintVerificationCodeData{
  int? quantity;
  String? url;

  PrintVerificationCodeData(this.quantity,this.url);

  PrintVerificationCodeData.fromJson(Map<String,dynamic>json){
    quantity = json['quantity'];
    url = json['url']??'';
  }
}
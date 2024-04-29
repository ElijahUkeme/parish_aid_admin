class UserAuthResetPasswordModel {
  String? terminus;
  String? status;
  ResetPasswordResponse? response;

  UserAuthResetPasswordModel(this.terminus, this.status, this.response);

  UserAuthResetPasswordModel.fromJson(Map<String, dynamic> json) {
    terminus = json['terminus'];
    status = json['status'];
    response = ResetPasswordResponse.fromJson(json['response']);
  }
}

class ResetPasswordResponse {
  int? code;
  String? title;
  String? message;

  ResetPasswordResponse(this.code, this.title, this.message);

  ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    message = json['message'];
  }
}

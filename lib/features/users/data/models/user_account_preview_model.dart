class UserAccountPreviewModel {
  final String? terminus;
  final String? status;
  final UserAccountPreviewReturnResponse? response;

  UserAccountPreviewModel({this.terminus, this.status, this.response});

  factory UserAccountPreviewModel.fromJson(Map<String, dynamic> json) =>
      UserAccountPreviewModel(
          terminus: json["terminus"],
          status: json["status"],
          response:
              UserAccountPreviewReturnResponse.fromJson(json["response"]));
}

class UserAccountPreviewReturnResponse {
  int? code;
  String? title;
  String? message;
  UserAccountPreviewResponse? data;
  UserAccountPreviewReturnResponse(
      {this.code, this.title, this.message, this.data});

  UserAccountPreviewReturnResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    title = json["title"];
    message = json["message"];
    if (json["data"] != null) {
      data = UserAccountPreviewResponse.fromJson(json["data"]);
    }
  }
}

class UserAccountPreviewResponse {
  int? id;
  String? firstName;
  String? email;
  String? phoneNumber;
  String? emailVerified;
  String? createdAt;
  String? updatedAt;

  UserAccountPreviewResponse(
      {this.id,
      this.firstName,
      this.email,
      this.phoneNumber,
      this.emailVerified,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["first_name"] = firstName;
    data["email"] = email;
    data["email_verified"] = emailVerified;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;

    return data;
  }

  factory UserAccountPreviewResponse.fromJson(Map<String, dynamic> json) =>
      UserAccountPreviewResponse(
          id: json["id"],
          firstName: json["first_name"],
          email: json["email"],
          phoneNumber: json["phone_number"],
          emailVerified: json["email_verified_at"],
          createdAt: json["created_at"],
          updatedAt: json["updated_at"]);
}

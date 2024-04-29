class UserAuthModel {
  final String? terminus;
  final String? status;
  final ReturnResponse? response;

  UserAuthModel({this.terminus, this.status, this.response});

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
      terminus: json["terminus"],
      status: json["status"],
      response: ReturnResponse.fromJson(json["response"]));
}

class ReturnResponse {
  int? code;
  String? title;
  String? message;
  Data? data;

  ReturnResponse(
      {required code, required title, required message, required data}) {
    this.code = code;
    this.title = title;
    this.message = message;
    this.data = data;
  }

  ReturnResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    title = json["title"];
    message = json["message"];
    if (json["data"] != null) {
      data = Data.fromJson(json["data"]);
    }
  }
}

class Data {
  String? token;
  UserResponse? admin;

  Data({required token, required admin}) {
    this.token = token;
    this.admin = admin;
  }

  Data.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    if (json["admin"] != null) {
      admin = UserResponse.fromJson(json["admin"]);
    }
  }
}

class UserResponse {
  int? id;
  String? firstName;
  String? email;
  String? phoneNumber;
  String? createdAt;
  String? updatedAt;

  UserResponse(
      {this.id,
      this.firstName,
      this.email,
      this.phoneNumber,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["first_name"] = firstName;
    data["email"] = email;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;

    return data;
  }

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
      id: json["id"],
      firstName: json["first_name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"]);
}

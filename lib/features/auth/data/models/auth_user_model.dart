import 'dart:convert';

import 'package:parish_aid_admin/features/auth/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  final String? terminus;
  final String? status;
  final ReturnResponse? response;

  const AuthUserModel({this.terminus, this.status, this.response});

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
      terminus: json["terminus"],
      status: json["status"],
      response: ReturnResponse.fromJson(json["response"]));

  factory AuthUserModel.fromJsonObject(String source) {
    final data = json.decode(source);
    return AuthUserModel(
        terminus: data["terminus"],
        status: data["status"],
        response: data["response" != null
            ? ReturnResponse.fromJsonObject(data["response"])
            : null]);
  }
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

  factory ReturnResponse.fromJsonObject(String source) {
    final data = json.decode(source);
    return ReturnResponse(
        code: data['code'] ?? '',
        title: data['title'] ?? '',
        message: data['message'] ?? '',
        data: data['data'] != null ? Data.fromJsonObject(data['data']) : null);
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
  AdminResponse? admin;

  Data({required token, required admin}) {
    this.token = token;
    this.admin = admin;
  }

  factory Data.fromJsonObject(String source) {
    final data = json.decode(source);
    return Data(
        token: data['token'],
        admin: data['admin'] != null
            ? AdminResponse.fromJson(data['admin'])
            : null);
  }

  Data.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    if (json["admin"] != null) {
      admin = AdminResponse.fromJson(json["admin"]);
    }
  }
}

class AdminResponse {
  int? id;
  String? firstName;
  String? email;
  String? phoneNumber;
  String? emailVerified;
  String? createdAt;
  String? updatedAt;

  AdminResponse(
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

  factory AdminResponse.fromJson(Map<String, dynamic> json) => AdminResponse(
      id: json["id"],
      firstName: json["first_name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      emailVerified: json["email_verified"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"]);
}

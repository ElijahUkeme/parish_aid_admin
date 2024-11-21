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
  UserResponse? user;

  Data({required this.token, required this.user});

  factory Data.fromJsonObject(String source) {
    final data = json.decode(source);
    return Data(
        token: data['token'],
        user: UserResponse.fromMap(data['user']));
  }

  Data.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    if (json["user"] != null) {
      user = UserResponse.fromJson(json["user"]);
    }
  }


  String get toJson {
    final body = {
      'token': token,
      'user': user!.toJson
    };
    return json.encode(body);
  }
}

class UserResponse {
  int? id;
  String? firstName;
  String? email;
  String? phoneNumber;
  String? emailVerified;
  String? createdAt;
  String? updatedAt;

  UserResponse(
      {this.id,
      this.firstName,
      this.email,
      this.phoneNumber,
      this.emailVerified,
      this.createdAt,
      this.updatedAt});

  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> data = <String, dynamic>{};
  //   data["id"] = id;
  //   data["first_name"] = firstName;
  //   data["email"] = email;
  //   data["email_verified"] = emailVerified;
  //   data["created_at"] = createdAt;
  //   data["updated_at"] = updatedAt;
  //
  //   return data;
  // }

  String get toJson {
    final body = {
      'id': id,
      'first_name': firstName,
      'email': email,
      'phoneNumber': phoneNumber,
      'emailVerified': emailVerified,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
    return json.encode(body);
  }

  factory UserResponse.fromMap(String source) {
    final data = json.decode(source);
    return UserResponse(
        id: data["id"],
        firstName: data["first_name"],
        email: data["email"],
        phoneNumber: data["phone_number"],
        emailVerified: data["email_verified"],
        createdAt: data["created_at"],
        updatedAt: data["updated_at"]);
  }


  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
      id: json["id"],
      firstName: json["first_name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      emailVerified: json["email_verified"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"]);
}

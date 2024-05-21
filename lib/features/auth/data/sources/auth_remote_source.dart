import 'dart:convert';

import 'package:parish_aid_admin/api/api_client.dart';
import 'package:parish_aid_admin/core/api/api_auth.dart';
import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/core/errors/exceptions.dart';
import 'package:parish_aid_admin/core/json_checker/json_checker.dart';
import 'package:parish_aid_admin/core/utils/strings.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/forgot_password.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/login_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/request_otp.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/reset_password.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/sign_up_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/verify_otp.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/verify_user.dart';
import 'package:parish_aid_admin/widgets/auth/auth_widgets.dart';

import '../models/auth_user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteSource {
  Future<AuthUserModel> verifyUser(VerifyUserParams params);

  Future<AuthUserModel> loginUser(LoginUserParams params);

  Future<AuthUserModel> signUpUser(SignUpUserParams params);

  Future<bool> logoutUser();

  Future<bool> forgotPassword(ForgotPasswordParams params);

  Future<bool> resetPassword(ResetPasswordParams params);
  Future<bool> verifyOtp(VerifyOtpParams params);
  Future<bool> requestOtp(RequestOtpParams params);
}

class AuthRemoteSourceImpl extends AuthRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  AuthRemoteSourceImpl({required this.client, required this.jsonChecker});

  @override
  Future<AuthUserModel> loginUser(LoginUserParams params) async {
    final body = {"email": params.email, "password": params.password};
    final response = await client
        .post(Uri.parse(userLogin),
            body: json.encode(body), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      print("Login response returns ${data.toString()}");
      if (data['status'] == 'OK') {
        //parse the json response to dart object
        return AuthUserModel.fromJson(data);
      } else if (data['response']['code'] == 461) {
        throw ServerException(data['response']['message']);
      } else if (data['response']['code'] == 422) {
        throw ServerException(data['response']['message']);
      } else {
        throw ServerException(data['response']['message']);
      }
    } else {
      throw const FormatException();
    }
  }

  @override
  Future<AuthUserModel> signUpUser(SignUpUserParams params) async {
    final body = {
      'first_name': params.firstname,
      'last_name': params.lastname,
      'email': params.email,
      'password': params.password
    };
    final response = await client
        .post(
          Uri.parse(userSignUp),
          body: json.encode(body),
          headers: await getHeaders(),
        )
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return AuthUserModel.fromJson(data);
      } else {
        throw ServerException(data['response']['message']);
      }
    } else {
      throw const FormatException();
    }
  }

  @override
  Future<AuthUserModel> verifyUser(VerifyUserParams params) async {
    final body = {'email': params.email};
    final response = await client.post(Uri.parse(userPreview),
        body: json.encode(body), headers: ApiClient.header);
    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        print("From the auth remote is $data");
        return AuthUserModel.fromJson(data);
      } else {
        print("From the auth remote is ${json.decode(response.body)}");
        return AuthUserModel.fromJson(data);
      }
    } else {
      throw const FormatException();
    }
  }

  @override
  Future<bool> logoutUser() async {
    final response = await client
        .post(Uri.parse(signOut), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));
    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status' == 'OK']) {
        return true;
      } else {
        throw ServerException(data['response']['message']);
      }
    } else {
      throw const FormatException();
    }
  }

  @override
  Future<bool> forgotPassword(ForgotPasswordParams params) async {
    final body = {};

    if (params.identifier.contains("@")) {
      body.addAll({'email': params.identifier.trim()});
    }

    final response = await client
        .post(Uri.parse(forgotPasswordEndPoint),
            body: json.encode(body), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));
    print("Forgot password response returns ${response.body}");

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        print("Forgot password response $data");
        return true;
      } else if (data['response']['code'] == unsupportedAccessErrorCode) {
        throw ServerException(data['response']['message']);
      } else {
        throw ServerException(serverErrorMsg);
      }
    } else {
      throw const FormatException('Invalid response');
    }
  }

  @override
  Future<bool> resetPassword(ResetPasswordParams params) async {
    final body = {
      'password': params.newPassword.trim(),
      'password_confirmation': params.newPassword.trim(),
      'email': params.email.trim(),
      'code': params.otp.trim()
    };
    final response = await client
        .post(Uri.parse(passwordResetEndPoint),
            body: json.encode(body), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);
      print("Reset password returns $data");

      if (data['status'] == 'OK') {
        return true;
      } else if (data['response']['code'] == unsupportedAccessErrorCode) {
        print(data['response']['message']);
        throw ServerException(data['response']['message']);
      } else {
        print(data['response']['message']);
        throw ServerException(serverErrorMsg);
      }
    } else {
      throw const FormatException('Invalid response');
    }
  }

  @override
  Future<bool> verifyOtp(VerifyOtpParams params) async {
    final body = {};
    if (params.email != null && params.email.isNotEmpty) {
      body.addAll({'email': params.email.trim()});
    }
    if (params.otp != null && params.otp.isNotEmpty) {
      body.addAll({'code': params.otp.trim()});
    }
    if (params.type != null && params.type!.isNotEmpty) {
      body.addAll({'type': params.type});
    }
    final response = await client
        .post(Uri.parse(otpVerifyEndPoint),
            body: json.encode(body), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);
      print("Data is $data");
      if (data['status'] == null) {
        print(data['message']);
        toastInfo(msg: data['message']);
        return false;
      }
      if (data['status' == 'OK']) {
        return true;
      } else if (data['response']['code'] == unsupportedAccessErrorCode) {
        throw ServerException(data['response']['message']);
      } else {
        throw ServerException(serverErrorMsg);
      }
    } else {
      throw const FormatException('Invalid response');
    }
  }

  @override
  Future<bool> requestOtp(RequestOtpParams params) async {
    final body = {};

    if (params.email.contains("@")) {
      body.addAll({'email': params.email.trim()});
    }

    final response = await client
        .post(Uri.parse(otpRequestEndPoint),
            body: json.encode(body), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);

      if (data['status'] == null) {
        print(data['message']);
        toastInfo(msg: data['message']);
        return false;
      }
      if (data['status' == 'OK']) {
        return true;
      } else if (data['response']['code'] == unsupportedAccessErrorCode) {
        throw ServerException(data['response']['message']);
      } else {
        throw ServerException(serverErrorMsg);
      }
    } else {
      throw const FormatException('Invalid response');
    }
  }
}

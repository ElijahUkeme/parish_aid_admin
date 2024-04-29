import 'dart:convert';

import 'package:parish_aid_admin/core/api/api_endpoints.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_account_preview.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_forgot_password.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_logout.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_verify_otp.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_login.dart';

import '../../../../api/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/json_checker/json_checker.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/usecases/user_auth_reset_password.dart';
import '../models/user_account_fetch_model.dart';
import '../models/user_account_preview_model.dart';
import '../models/user_auth_model.dart';
import 'package:http/http.dart' as http;

import '../models/user_auth_reset_password_model.dart';

abstract class UserAuthRemoteSource {
  Future<UserAuthModel> loginUser(UserLoginParams params);

  Future<UserAccountFetchModel> fetchAccount();

  Future<UserAccountPreviewModel> previewUser(UserAccountPreviewParams params);

  Future<bool> logoutAuthUser(UserAuthLogoutParams params);

  Future<bool> userAuthForgotPassword(UserAuthForgotPasswordParams params);

  Future<UserAuthResetPasswordModel> userResetPassword(
      UserAuthResetPasswordParams params);

  Future<bool> verifyUserAuthOtp(UserAuthVerifyOtpParams params);
}

class UserAuthRemoteSourceImpl extends UserAuthRemoteSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  UserAuthRemoteSourceImpl({required this.client, required this.jsonChecker});

  @override
  Future<UserAuthModel> loginUser(UserLoginParams params) async {
    final body = {"email": params.email, "password": params.password};
    final response = await client
        .post(Uri.parse(userLoginEndPoint),
            body: json.encode(body), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      print("Login response returns ${data.toString()}");
      if (data['status'] == 'OK') {
        //parse the json response to dart object
        return UserAuthModel.fromJson(data);
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
  Future<UserAccountFetchModel> fetchAccount() async {
    final response = await client
        .get(Uri.parse(userAccountFetchEndPoint), headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return UserAccountFetchModel.fromJson(data);
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
  Future<UserAccountPreviewModel> previewUser(
      UserAccountPreviewParams params) async {
    final body = {'email': params.email};
    final response = await client.post(Uri.parse(userPreviewEndPoint),
        body: json.encode(body), headers: ApiClient.header);
    if (await jsonChecker.isJson(response.body)) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        print("From the auth remote is $data");
        return UserAccountPreviewModel.fromJson(data);
      } else {
        print("From the auth remote is ${json.decode(response.body)}");
        return UserAccountPreviewModel.fromJson(data);
      }
    } else {
      throw const FormatException();
    }
  }

  @override
  Future<bool> logoutAuthUser(UserAuthLogoutParams params) async {
    final response = await client
        .post(Uri.parse(userAuthLogoutEndPoint), headers: ApiClient.header)
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
  Future<bool> userAuthForgotPassword(
      UserAuthForgotPasswordParams params) async {
    final body = {};

    if (params.email.contains("@")) {
      body.addAll({'email': params.email.trim()});
    }

    final response = await client
        .post(Uri.parse(userAuthForgotPasswordEndPoint),
            body: body, headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));
    print("Logout response returns ${response.body}");

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
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
  Future<UserAuthResetPasswordModel> userResetPassword(
      UserAuthResetPasswordParams params) async {
    final body = {
      'password': params.passwordConfirmation.trim(),
      'password_confirmation': params.passwordConfirmation.trim(),
      'email': params.email.trim(),
      'code': params.code
    };
    final response = await client
        .post(Uri.parse(userAuthResetPasswordEndPoint),
            body: body, headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        return UserAuthResetPasswordModel.fromJson(data);
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
  Future<bool> verifyUserAuthOtp(UserAuthVerifyOtpParams params) async {
    final body = {};
    if (params.email != null && params.email.isNotEmpty) {
      body.addAll({'email': params.email.trim()});
    }
    if (params.otp != null) {
      body.addAll({'code': params.otp});
    }
    if (params.type != null && params.type!.isNotEmpty) {
      body.addAll({'type': params.type});
    }
    final response = await client
        .post(Uri.parse(userAuthOtpVerifyEndPoint),
            body: body, headers: ApiClient.header)
        .timeout(const Duration(seconds: 20));

    if ((await jsonChecker.isJson(response.body))) {
      final data = json.decode(response.body);
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

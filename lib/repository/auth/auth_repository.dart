import 'dart:convert';

import 'package:parish_aid_admin/api/api_client.dart';
import 'package:parish_aid_admin/constants/app_url_constants.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/model/auth/auth_model.dart';
import 'package:parish_aid_admin/model/auth/login_model.dart';
import 'package:parish_aid_admin/model/auth/sign_up_model.dart';

import '../../response/auth_response.dart';

class AuthRepository {
  static Future<AuthUserModel> signUp(SignUpModel signUpModel) async {
    var response = await ApiClient.postData(
        AppUrlConstant.REGISTER_URL, signUpModel.toJson());
    print("The response in the repo returns $response");
    return AuthUserModel.fromJson(json.decode(response.body));
  }

  static Future<AuthUserModel> login(LoginModel loginModel) async {
    var response =
        await ApiClient.postData(AppUrlConstant.LOGIN_URL, loginModel.toJson());
    return AuthUserModel.fromJson(json.decode(response.body));
  }

  static Future<AuthUserModel> preview(AuthModel authModel) async {
    var response = await ApiClient.postData(
        AppUrlConstant.USER_PREVIEW_URL, authModel.toJson());
    print("The response code is now ${response.statusCode}");
    return AuthUserModel.fromJson(json.decode(response.body));
  }
}

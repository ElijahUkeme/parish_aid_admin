import 'dart:convert';

import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/api/api_client.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/network_info/network_info.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/auth/data/sources/auth_local_source.dart';
import 'package:parish_aid_admin/features/auth/data/sources/auth_remote_source.dart';
import 'package:parish_aid_admin/features/auth/domain/repository/auth_repository.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/forgot_password.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/login_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/logout_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/reset_password.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/sign_up_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/verify_otp.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/verify_user.dart';
import 'package:parish_aid_admin/features/users/data/models/user_auth_model.dart';

import '../../domain/usecase/request_otp.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteSource authRemoteSource;
  final NetworkInfo networkInfo;
  final AuthLocalSource authLocalSource;

  AuthRepositoryImpl(
      {required this.authRemoteSource,
      required this.networkInfo,
      required this.authLocalSource});

  @override
  Future<Either<Failure, AuthUserModel>> signInUser(LoginUserParams params) async {
    return ServiceRunner<AuthUserModel>(
      networkInfo: networkInfo,
    ).runNetworkTask(() async {
      //call login from authRemoteSource
      final result = await authRemoteSource.loginUser(params);
      //cache the user data in the local storage

      await authLocalSource.cachedUserAuth(result.response!.data!);
      return result;
    });
  }

  @override
  Future<Either<Failure, AuthUserModel>> signUpUser(SignUpUserParams params) async {
    return ServiceRunner<AuthUserModel>(networkInfo: networkInfo)
        .runNetworkTask(() async {
      //call sign up from the authResource
      final result = await authRemoteSource.signUpUser(params);
      //cache the user data from the newly registered user
      await authLocalSource.cachedUserAuth(result.response!.data!);
      return result;
    });
  }

  @override
  Future<Either<Failure, AuthUserModel>> verifyUser(VerifyUserParams params) {
    return ServiceRunner<AuthUserModel>(networkInfo: networkInfo)
        .runNetworkTask(() {
      return authRemoteSource.verifyUser(params);
    });
  }

  @override
  Future<Either<Failure, bool>> logoutUser(LogoutUserParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => authRemoteSource.logoutUser());
  }

  @override
  Future<Either<Failure, bool>> forgotPassword(ForgotPasswordParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => authRemoteSource.forgotPassword(params));
  }

  @override
  Future<Either<Failure, bool>> resetPassword(ResetPasswordParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => authRemoteSource.resetPassword(params));
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(VerifyOtpParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => authRemoteSource.verifyOtp(params));
  }

  @override
  Future<Either<Failure, bool>> requestOtp(RequestOtpParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => authRemoteSource.requestOtp(params));
  }

}

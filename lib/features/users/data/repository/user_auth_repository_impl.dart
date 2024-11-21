import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_preview_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_auth_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_auth_reset_password_model.dart';
import 'package:parish_aid_admin/features/users/data/sources/user_auth_local_source.dart';
import 'package:parish_aid_admin/features/users/data/sources/user_auth_remote_source.dart';
import 'package:parish_aid_admin/features/users/domain/repository/user_auth_repository.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_account_preview.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_forgot_password.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_logout.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_reset_password.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_verify_otp.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_login.dart';

import '../../../../api/api_client.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../core/service_runner/service_runner.dart';

class UserAuthRepositoryImpl extends UserAuthRepository {
  final NetworkInfo networkInfo;
  final UserAuthRemoteSource userAuthRemoteSource;
  final UserAuthLocalSource userAuthLocalSource;

  UserAuthRepositoryImpl(
      {required this.networkInfo,
      required this.userAuthRemoteSource,
      required this.userAuthLocalSource});

  @override
  Future<Either<Failure, AuthUserModel>> signInUser(UserLoginParams params) {
    return ServiceRunner<AuthUserModel>(
      networkInfo: networkInfo,
    ).runNetworkTask(() async {
      //call login from authRemoteSource
      final result = await userAuthRemoteSource.loginUser(params);
      await userAuthLocalSource.cachedUserAuth(result.response!.data!);
      //cache the new token returned from the server
      return result;
    });
  }

  @override
  Future<Either<Failure, UserAccountFetchModel>> fetchAccount() {
    return ServiceRunner<UserAccountFetchModel>(networkInfo: networkInfo)
        .runNetworkTask(() => userAuthRemoteSource.fetchAccount());
  }

  @override
  Future<Either<Failure, UserAccountPreviewModel>> previewAccount(
      UserAccountPreviewParams params) {
    return ServiceRunner<UserAccountPreviewModel>(networkInfo: networkInfo)
        .runNetworkTask(() => userAuthRemoteSource.previewUser(params));
  }

  @override
  Future<Either<Failure, bool>> logoutAuthUser(UserAuthLogoutParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => userAuthRemoteSource.logoutAuthUser(params));
  }

  @override
  Future<Either<Failure, UserAuthResetPasswordModel>> userAuthForgotPassword(
      UserAuthForgotPasswordParams params) {
    return ServiceRunner<UserAuthResetPasswordModel>(networkInfo: networkInfo).runNetworkTask(
        () => userAuthRemoteSource.userAuthForgotPassword(params));
  }

  @override
  Future<Either<Failure, UserAuthResetPasswordModel>> userPasswordReset(
      UserAuthResetPasswordParams params) {
    return ServiceRunner<UserAuthResetPasswordModel>(networkInfo: networkInfo)
        .runNetworkTask(() => userAuthRemoteSource.userResetPassword(params));
  }

  @override
  Future<Either<Failure, bool>> verifyUserOtp(UserAuthVerifyOtpParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => userAuthRemoteSource.verifyUserAuthOtp(params));
  }
}

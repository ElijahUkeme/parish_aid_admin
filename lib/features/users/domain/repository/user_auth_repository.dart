import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_preview_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_auth_model.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_account_preview.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_forgot_password.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_logout.dart';

import '../../../../core/failures/failure.dart';
import '../../data/models/user_auth_reset_password_model.dart';
import '../usecases/user_auth_reset_password.dart';
import '../usecases/user_auth_verify_otp.dart';
import '../usecases/user_login.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, AuthUserModel>> signInUser(UserLoginParams params);
  Future<Either<Failure, UserAccountFetchModel>> fetchAccount();
  Future<Either<Failure, UserAccountPreviewModel>> previewAccount(
      UserAccountPreviewParams params);
  Future<Either<Failure, bool>> logoutAuthUser(UserAuthLogoutParams params);
  Future<Either<Failure, UserAuthResetPasswordModel>> userAuthForgotPassword(
      UserAuthForgotPasswordParams params);
  Future<Either<Failure, UserAuthResetPasswordModel>> userPasswordReset(
      UserAuthResetPasswordParams params);
  Future<Either<Failure, bool>> verifyUserOtp(UserAuthVerifyOtpParams params);
}

import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/forgot_password.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/login_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/logout_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/request_otp.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/reset_password.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/sign_up_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/verify_otp.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/verify_user.dart';
import 'package:parish_aid_admin/features/users/data/models/user_auth_model.dart';
import '../../../../core/failures/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUserModel>> signUpUser(SignUpUserParams params);

  Future<Either<Failure, AuthUserModel>> signInUser(LoginUserParams params);

  Future<Either<Failure, AuthUserModel>> verifyUser(VerifyUserParams params);
  Future<Either<Failure, bool>> logoutUser(LogoutUserParams params);
  Future<Either<Failure, bool>> forgotPassword(ForgotPasswordParams params);
  Future<Either<Failure, bool>> resetPassword(ResetPasswordParams params);
  Future<Either<Failure, bool>> verifyOtp(VerifyOtpParams params);
  Future<Either<Failure, bool>> requestOtp(RequestOtpParams params);
}

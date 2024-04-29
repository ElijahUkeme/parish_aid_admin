import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/auth/domain/repository/auth_repository.dart';

class ResetPassword extends Usecase<bool, ResetPasswordParams> {
  final AuthRepository authRepository;
  ResetPassword(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(ResetPasswordParams params) {
    return authRepository.resetPassword(params);
  }
}

class ResetPasswordParams extends Equatable {
  final String oldPassword;
  final String newPassword;
  final String email;
  final String otp;

  const ResetPasswordParams(
      {required this.oldPassword,
      required this.newPassword,
      required this.email,
      required this.otp});

  @override
  // TODO: implement props
  List<Object?> get props => [oldPassword, newPassword, email, otp];
}

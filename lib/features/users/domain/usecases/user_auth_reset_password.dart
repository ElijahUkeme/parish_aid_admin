import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';

import '../../data/models/user_auth_reset_password_model.dart';
import '../repository/user_auth_repository.dart';

class UserAuthResetPassword
    extends Usecase<UserAuthResetPasswordModel, UserAuthResetPasswordParams> {
  final UserAuthRepository userAuthRepository;

  UserAuthResetPassword({required this.userAuthRepository});
  @override
  Future<Either<Failure, UserAuthResetPasswordModel>> call(
      UserAuthResetPasswordParams params) {
    return userAuthRepository.userPasswordReset(params);
  }
}

class UserAuthResetPasswordParams extends Equatable {
  final String email;
  final String password;
  final String code;
  final String passwordConfirmation;

  const UserAuthResetPasswordParams(
      {required this.email,
      required this.password,
      required this.code,
      required this.passwordConfirmation});

  @override
  List<Object?> get props => [];
}

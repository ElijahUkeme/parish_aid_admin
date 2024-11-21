import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/users/data/models/user_auth_reset_password_model.dart';

import '../repository/user_auth_repository.dart';

class UserAuthForgotPassword
    extends Usecase<UserAuthResetPasswordModel, UserAuthForgotPasswordParams> {
  final UserAuthRepository userAuthRepository;

  UserAuthForgotPassword({required this.userAuthRepository});

  @override
  Future<Either<Failure, UserAuthResetPasswordModel>> call(UserAuthForgotPasswordParams params) {
    return userAuthRepository.userAuthForgotPassword(params);
  }
}

class UserAuthForgotPasswordParams extends Equatable {
  final String email;

  const UserAuthForgotPasswordParams({required this.email});
  @override
  List<Object?> get props => [];
}

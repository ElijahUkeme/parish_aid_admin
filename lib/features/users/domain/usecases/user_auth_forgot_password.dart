import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';

import '../repository/user_auth_repository.dart';

class UserAuthForgotPassword
    extends Usecase<bool, UserAuthForgotPasswordParams> {
  final UserAuthRepository userAuthRepository;

  UserAuthForgotPassword({required this.userAuthRepository});

  @override
  Future<Either<Failure, bool>> call(UserAuthForgotPasswordParams params) {
    return userAuthRepository.userAuthForgotPassword(params);
  }
}

class UserAuthForgotPasswordParams extends Equatable {
  final String email;

  const UserAuthForgotPasswordParams({required this.email});
  @override
  List<Object?> get props => [];
}

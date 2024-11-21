import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_auth_model.dart';
import 'package:parish_aid_admin/features/users/domain/repository/user_auth_repository.dart';

class UserLogin extends Usecase<AuthUserModel, UserLoginParams> {
  final UserAuthRepository userAuthRepository;
  UserLogin({required this.userAuthRepository});

  @override
  Future<Either<Failure, AuthUserModel>> call(UserLoginParams params) {
    return userAuthRepository.signInUser(params);
  }
}

class UserLoginParams extends Equatable {
  final String email;
  final String password;

  const UserLoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

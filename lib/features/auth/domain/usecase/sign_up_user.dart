import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/auth/domain/repository/auth_repository.dart';
import 'package:parish_aid_admin/features/users/data/models/user_auth_model.dart';

class SignUpUser extends Usecase<AuthUserModel, SignUpUserParams> {
  final AuthRepository authRepository;
  SignUpUser(this.authRepository);

  @override
  Future<Either<Failure, AuthUserModel>> call(params) {
    return authRepository.signUpUser(params);
  }
}

class SignUpUserParams extends Equatable {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  const SignUpUserParams(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

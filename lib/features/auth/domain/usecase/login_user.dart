import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/auth/domain/repository/auth_repository.dart';

class LoginUser extends Usecase<bool, LoginUserParams> {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(params) {
    return authRepository.signInUser(params);
  }
}

class LoginUserParams extends Equatable {
  final String email;
  final String password;

  const LoginUserParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

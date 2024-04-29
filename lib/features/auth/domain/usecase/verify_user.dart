import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/auth/domain/repository/auth_repository.dart';

class VerifyUser extends Usecase<AuthUserModel, VerifyUserParams> {
  final AuthRepository authRepository;

  VerifyUser(this.authRepository);

  @override
  Future<Either<Failure, AuthUserModel>> call(VerifyUserParams params) {
    return authRepository.verifyUser(params);
  }
}

class VerifyUserParams extends Equatable {
  final String email;

  const VerifyUserParams({required this.email});
  @override
  List<Object?> get props => [email];
}

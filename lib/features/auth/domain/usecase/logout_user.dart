import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/auth/domain/repository/auth_repository.dart';

class LogoutUser extends Usecase<bool,LogoutUserParams>{

  final AuthRepository authRepository;
  LogoutUser(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(LogoutUserParams params) {
    return authRepository.logoutUser(params);
  }

}
class LogoutUserParams extends Equatable{
  @override

  List<Object?> get props => [];

}
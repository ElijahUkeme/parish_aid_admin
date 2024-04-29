import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/auth/domain/repository/auth_repository.dart';

class ForgotPassword extends Usecase<bool,ForgotPasswordParams>{
  final AuthRepository authRepository;
  ForgotPassword(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(ForgotPasswordParams params) {
   return authRepository.forgotPassword(params);
  }

}
class ForgotPasswordParams extends Equatable{
  final String identifier;
  const ForgotPasswordParams(this.identifier);

  @override

  List<Object?> get props =>[identifier];
}
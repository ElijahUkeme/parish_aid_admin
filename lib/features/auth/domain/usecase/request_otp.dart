import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/auth/domain/repository/auth_repository.dart';

class RequestOtp extends Usecase<bool, RequestOtpParams> {
  AuthRepository authRepository;

  RequestOtp(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(RequestOtpParams params) {
    return authRepository.requestOtp(params);
  }
}

class RequestOtpParams extends Equatable {
  final String email;

  const RequestOtpParams({required this.email});

  @override
  List<Object?> get props => [email];
}

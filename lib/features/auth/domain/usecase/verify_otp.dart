import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/auth/domain/repository/auth_repository.dart';

class VerifyOtp extends Usecase<bool, VerifyOtpParams> {
  final AuthRepository authRepository;
  VerifyOtp(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(VerifyOtpParams params) {
    return authRepository.verifyOtp(params);
  }
}

class VerifyOtpParams extends Equatable {
  final String email;
  final String otp;
  final String? type;

  const VerifyOtpParams({required this.email, required this.otp, this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';

import '../repository/user_auth_repository.dart';

class UserAuthVerifyOtp extends Usecase<bool, UserAuthVerifyOtpParams> {
  final UserAuthRepository userAuthRepository;

  UserAuthVerifyOtp({required this.userAuthRepository});

  @override
  Future<Either<Failure, bool>> call(UserAuthVerifyOtpParams params) {
    return userAuthRepository.verifyUserOtp(params);
  }
}

class UserAuthVerifyOtpParams extends Equatable {
  final String email;
  final int otp;
  final String? type;

  const UserAuthVerifyOtpParams(
      {required this.email, required this.otp, required this.type});

  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/users/domain/repository/user_auth_repository.dart';

class UserAuthLogout extends Usecase<bool, UserAuthLogoutParams> {
  final UserAuthRepository userAuthRepository;
  UserAuthLogout({required this.userAuthRepository});

  @override
  Future<Either<Failure, bool>> call(UserAuthLogoutParams params) {
    return userAuthRepository.logoutAuthUser(params);
  }
}

class UserAuthLogoutParams extends Equatable {
  @override
  List<Object?> get props => [];
}

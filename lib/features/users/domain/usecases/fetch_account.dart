import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';
import 'package:parish_aid_admin/features/users/domain/repository/user_auth_repository.dart';

class FetchAccount extends Usecase<UserAccountFetchModel,NoParams>{
  final UserAuthRepository userAuthRepository;

  FetchAccount({required this.userAuthRepository});

  @override
  Future<Either<Failure, UserAccountFetchModel>> call(params) {
    return userAuthRepository.fetchAccount();
  }
}
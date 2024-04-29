import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_preview_model.dart';
import 'package:parish_aid_admin/features/users/domain/repository/user_auth_repository.dart';

class UserAccountPreview
    extends Usecase<UserAccountPreviewModel, UserAccountPreviewParams> {
  final UserAuthRepository userAuthRepository;
  UserAccountPreview({required this.userAuthRepository});

  @override
  Future<Either<Failure, UserAccountPreviewModel>> call(
      UserAccountPreviewParams params) {
    return userAuthRepository.previewAccount(params);
  }
}

class UserAccountPreviewParams extends Equatable {
  final String email;
  const UserAccountPreviewParams({required this.email});

  @override
  List<Object?> get props => [email];
}

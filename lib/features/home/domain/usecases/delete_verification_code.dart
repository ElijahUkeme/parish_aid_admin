import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class DeleteVerificationCode extends Usecase<bool,DeleteVerificationCodeParams>{
  final HomeRepository homeRepository;
  DeleteVerificationCode(this.homeRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteVerificationCodeParams params) {
    return homeRepository.deleteVerificationCode(params);
  }
}

class DeleteVerificationCodeParams extends Equatable{
  final int parish;
  final int code;

  const DeleteVerificationCodeParams(this.parish,this.code);

  @override
  List<Object?> get props => [];
}
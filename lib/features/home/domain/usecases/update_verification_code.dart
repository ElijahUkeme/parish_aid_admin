import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class UpdateVerificationCode extends Usecase<VerificationCodeModel,UpdateVerificationCodeParams>{
  final HomeRepository homeRepository;

  UpdateVerificationCode(this.homeRepository);

  @override
  Future<Either<Failure, VerificationCodeModel>> call(UpdateVerificationCodeParams params) {
    return homeRepository.updateVerificationCode(params);
  }
}

class UpdateVerificationCodeParams extends Equatable{
  final int parishId;
  final int vCodeId;
  final int? printStatus;
  final String? status;
  final String? expiresAt;

  const UpdateVerificationCodeParams(this.parishId,this.vCodeId,this.printStatus,this.status,this.expiresAt);

  @override
  List<Object?> get props => [];
}
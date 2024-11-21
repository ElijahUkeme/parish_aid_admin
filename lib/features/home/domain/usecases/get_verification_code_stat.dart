import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_stat_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class GetVerificationCodeStat extends Usecase<VerificationCodeStatModel,GetVerificationCodeStatParam>{
  final HomeRepository homeRepository;
  GetVerificationCodeStat(this.homeRepository);

  @override
  Future<Either<Failure, VerificationCodeStatModel>> call(GetVerificationCodeStatParam params) {
    return homeRepository.getVerificationCodeStat(params);
  }
}

class GetVerificationCodeStatParam extends Equatable{
  final int parish;
  const GetVerificationCodeStatParam(this.parish);

  @override
  List<Object?> get props => [];
}
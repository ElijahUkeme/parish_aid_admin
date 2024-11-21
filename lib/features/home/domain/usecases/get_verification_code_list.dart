import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class GetVerificationCodeList extends Usecase<VerificationCodeModel,GetVerificationCodeListParam>{
  final HomeRepository homeRepository;
  GetVerificationCodeList(this.homeRepository);

  @override
  Future<Either<Failure, VerificationCodeModel>> call(GetVerificationCodeListParam param) {
    return homeRepository.getVerificationCodeList(param);
  }
}

class GetVerificationCodeListParam extends Equatable{
  final int parish;
  const GetVerificationCodeListParam(this.parish);

  @override
  List<Object?> get props => [];
}
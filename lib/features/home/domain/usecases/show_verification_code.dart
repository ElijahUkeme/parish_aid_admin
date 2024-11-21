import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class ShowVerificationCode extends Usecase<VerificationCodeData,ShowVerificationCodeParam>{
  final HomeRepository homeRepository;
  ShowVerificationCode(this.homeRepository);

  @override
  Future<Either<Failure, VerificationCodeData>> call(ShowVerificationCodeParam params) {
   return homeRepository.showVerificationCode(params);
  }
}

class ShowVerificationCodeParam extends Equatable{
  final int parish;
  final int code;
  const ShowVerificationCodeParam(this.parish,this.code);

  @override
  List<Object?> get props => [];
}
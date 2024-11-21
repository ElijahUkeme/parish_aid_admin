import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class CreateVerificationCode extends Usecase<VerificationCodeModel,CreateVerificationCodeParams>{
  final HomeRepository homeRepository;
  CreateVerificationCode(this.homeRepository);

  @override
  Future<Either<Failure, VerificationCodeModel>> call(CreateVerificationCodeParams params) {
    return homeRepository.createVerificationCode(params);
  }
}

class CreateVerificationCodeParams extends Equatable{
  final int parishId;
  final int quantity;
  final String expiresAt;


  const CreateVerificationCodeParams({required this.parishId,required this.quantity,required this.expiresAt});

  @override
  List<Object?> get props => [];

}
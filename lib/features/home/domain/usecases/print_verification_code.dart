import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/print_verification_code_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class PrintVerificationCode extends Usecase<PrintVerificationCodeModel,PrintVerificationCodeParams>{

  final HomeRepository homeRepository;
  PrintVerificationCode(this.homeRepository);

  @override
  Future<Either<Failure, PrintVerificationCodeModel>> call(PrintVerificationCodeParams params) {
   return homeRepository.printVerification(params);
  }
}

class PrintVerificationCodeParams extends Equatable{
   final int parishId;
   final int quantity;

   const PrintVerificationCodeParams(this.parishId,this.quantity);
  @override
  List<Object?> get props => [];
}
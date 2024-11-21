import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/home/data/model/get_parish_model.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/data/model/print_verification_code_model.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_stat_model.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/approve_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/create_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/create_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/delete_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/delete_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_verification_code_list.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_verification_code_stat.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/print_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/show_verification_code.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/update_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/update_verification_code.dart';

abstract class HomeRepository {
  Future<Either<Failure, ParishModel>> getParishes();
  Future<Either<Failure, GetParishModel>> getParish(GetParishParam param);
  Future<Either<Failure, GetParishModel>> updateParish(UpdateParishParams params);
  Future<Either<Failure, ParishModel>> createParish(CreateParishParams params);
  Future<Either<Failure, GetParishModel>> approveParish(ApproveParishParam param);
  Future<Either<Failure, bool>> deleteParish(DeleteParishParam param);
  Future<Either<Failure,VerificationCodeModel>> createVerificationCode(CreateVerificationCodeParams params);
  Future<Either<Failure,VerificationCodeModel>> updateVerificationCode(UpdateVerificationCodeParams params);
  Future<Either<Failure,PrintVerificationCodeModel>> printVerification(PrintVerificationCodeParams params);
  Future<Either<Failure,VerificationCodeModel>> getVerificationCodeList(GetVerificationCodeListParam param);
  Future<Either<Failure,VerificationCodeStatModel>> getVerificationCodeStat(GetVerificationCodeStatParam param);
  Future<Either<Failure,VerificationCodeData>> showVerificationCode(ShowVerificationCodeParam params);
  Future<Either<Failure,bool>> deleteVerificationCode(DeleteVerificationCodeParams params);
}

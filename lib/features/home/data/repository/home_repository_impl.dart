import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/network_info/network_info.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/home/data/model/get_parish_model.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/data/model/print_verification_code_model.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_stat_model.dart';
import 'package:parish_aid_admin/features/home/data/sources/home_local_source.dart';
import 'package:parish_aid_admin/features/home/data/sources/home_remote_source.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';
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

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteSource homeRemoteSource;
  final HomeLocalSource homeLocalSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl(
      {required this.homeRemoteSource,
      required this.homeLocalSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, ParishModel>> getParishes() {
    return ServiceRunner<ParishModel>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.getParishes());
  }

  @override
  Future<Either<Failure, GetParishModel>> getParish(GetParishParam param) {
    return ServiceRunner<GetParishModel>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.getParish(param));
  }

  @override
  Future<Either<Failure, GetParishModel>> updateParish(UpdateParishParams params) {
    return ServiceRunner<GetParishModel>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.updateParish(params));
  }

  @override
  Future<Either<Failure, ParishModel>> createParish(CreateParishParams params) {
    return ServiceRunner<ParishModel>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.createParish(params));
  }

  @override
  Future<Either<Failure, GetParishModel>> approveParish(ApproveParishParam param) {
    return ServiceRunner<GetParishModel>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.approveParish(param));
  }

  @override
  Future<Either<Failure, bool>> deleteParish(DeleteParishParam param) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.deleteParish(param));
  }

  @override
  Future<Either<Failure, VerificationCodeModel>> createVerificationCode(CreateVerificationCodeParams params) {
   return ServiceRunner<VerificationCodeModel>(networkInfo: networkInfo)
       .runNetworkTask(()=>homeRemoteSource.createVerificationCode(params));
  }

  @override
  Future<Either<Failure, VerificationCodeModel>> updateVerificationCode(UpdateVerificationCodeParams params) {
    return ServiceRunner<VerificationCodeModel>(networkInfo: networkInfo)
        .runNetworkTask(()=>homeRemoteSource.updateVerificationCode(params));
  }

  @override
  Future<Either<Failure, PrintVerificationCodeModel>> printVerification(PrintVerificationCodeParams params) {
    return ServiceRunner<PrintVerificationCodeModel>(networkInfo: networkInfo)
        .runNetworkTask(()=>homeRemoteSource.printVerification(params));
  }

  @override
  Future<Either<Failure, VerificationCodeModel>> getVerificationCodeList(GetVerificationCodeListParam param) {
return ServiceRunner<VerificationCodeModel>(networkInfo: networkInfo)
    .runNetworkTask(()=>homeRemoteSource.getVerificationCodeList(param));
  }

  @override
  Future<Either<Failure, VerificationCodeStatModel>> getVerificationCodeStat(GetVerificationCodeStatParam param) {
    return ServiceRunner<VerificationCodeStatModel>(networkInfo: networkInfo)
        .runNetworkTask(()=>homeRemoteSource.getVerificationCodeStat(param));
  }

  @override
  Future<Either<Failure, VerificationCodeData>> showVerificationCode(ShowVerificationCodeParam params) {
    return ServiceRunner<VerificationCodeData>(networkInfo: networkInfo)
        .runNetworkTask(()=>homeRemoteSource.showVerificationCode(params));
  }

  @override
  Future<Either<Failure, bool>> deleteVerificationCode(DeleteVerificationCodeParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(()=>homeRemoteSource.deleteVerificationCode(params));
  }
}

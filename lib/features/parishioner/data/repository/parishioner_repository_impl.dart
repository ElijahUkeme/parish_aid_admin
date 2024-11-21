import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_list_model.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_model.dart';
import 'package:parish_aid_admin/features/parishioner/data/sources/parishioner_remote_source.dart';
import 'package:parish_aid_admin/features/parishioner/domain/repository/parishioner_repository.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/create_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/delete_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/get_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/get_parishioners.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/update_parishioner.dart';

import '../../../../core/network_info/network_info.dart';

class ParishionerRepositoryImpl extends ParishionerRepository{
  final ParishionerRemoteSource parishionerRemoteSource;
  final NetworkInfo networkInfo;
  ParishionerRepositoryImpl({required this.parishionerRemoteSource,required this.networkInfo});

  @override
  Future<Either<Failure, ParishionerModel>> createParishioner(CreateParishionerParams params) {
    return ServiceRunner<ParishionerModel>(networkInfo: networkInfo)
        .runNetworkTask(() => parishionerRemoteSource.createParishioner(params));
  }

  @override
  Future<Either<Failure, ParishionerModel>> updateParishioner(UpdateParishionerParams params) {
    return ServiceRunner<ParishionerModel>(networkInfo: networkInfo)
        .runNetworkTask(() => parishionerRemoteSource.updateParishioner(params));
  }

  @override
  Future<Either<Failure, ParishionerListModel>> getParishioners(GetParishionersParam param) {
    return ServiceRunner<ParishionerListModel>(networkInfo: networkInfo)
        .runNetworkTask(() => parishionerRemoteSource.getParishioners(param));
  }

  @override
  Future<Either<Failure, ParishionerModel>> getParishioner(GetParishionerParams params) {

    return ServiceRunner<ParishionerModel>(networkInfo: networkInfo)
        .runNetworkTask(() => parishionerRemoteSource.getParishioner(params));
  }

  @override
  Future<Either<Failure, bool>> deleteParishioner(DeleteParishionerParams params) {

    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => parishionerRemoteSource.deleteParishioner(params));
  }

}
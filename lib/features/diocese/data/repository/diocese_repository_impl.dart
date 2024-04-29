import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/diocese/data/models/diocese_model.dart';
import 'package:parish_aid_admin/features/diocese/data/sources/diocese_local_source.dart';
import 'package:parish_aid_admin/features/diocese/data/sources/diocese_remote_source.dart';
import 'package:parish_aid_admin/features/diocese/domain/repository/diocese_repository.dart';
import 'package:parish_aid_admin/features/diocese/domain/usecases/show_diocese.dart';

import '../../../../core/network_info/network_info.dart';

class DioceseRepositoryImpl extends DioceseRepository {
  final DioceseRemoteSource dioceseRemoteSource;
  final DioceseLocalSource dioceseLocalSource;
  final NetworkInfo networkInfo;

  DioceseRepositoryImpl(
      {required this.dioceseRemoteSource,
      required this.dioceseLocalSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, DioceseModel>> getDioceses() {
    return ServiceRunner<DioceseModel>(networkInfo: networkInfo)
        .runNetworkTask(() => dioceseRemoteSource.getDioceses());
  }

  @override
  Future<Either<Failure, DioceseModel>> showDiocese(ShowDioceseParams params) {
    return ServiceRunner<DioceseModel>(networkInfo: networkInfo)
        .runNetworkTask(() => dioceseRemoteSource.showDiocese(params));
  }
}

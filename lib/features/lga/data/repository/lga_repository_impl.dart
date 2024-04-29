import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/lga/data/models/lga_model.dart';
import 'package:parish_aid_admin/features/lga/data/sources/lga_local_source.dart';
import 'package:parish_aid_admin/features/lga/data/sources/lga_remote_source.dart';
import 'package:parish_aid_admin/features/lga/domain/repository/lga_repository.dart';
import 'package:parish_aid_admin/features/lga/domain/usecases/get_lga.dart';

import '../../../../core/network_info/network_info.dart';

class LgaRepositoryImpl extends LgaRepository {
  final LgaRemoteSource lgaRemoteSource;
  final LgaLocalSource lgaLocalSource;
  final NetworkInfo networkInfo;

  LgaRepositoryImpl(
      {required this.lgaRemoteSource,
      required this.lgaLocalSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, LgaModel>> getLga(GetLgaParams params) {
    return ServiceRunner<LgaModel>(networkInfo: networkInfo)
        .runNetworkTask(() => lgaRemoteSource.getLga(params));
  }
}

import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/town/data/models/town_model.dart';
import 'package:parish_aid_admin/features/town/data/sources/town_local_source.dart';
import 'package:parish_aid_admin/features/town/data/sources/town_remote_source.dart';
import 'package:parish_aid_admin/features/town/domain/repository/town_repository.dart';
import 'package:parish_aid_admin/features/town/domain/usecases/get_town.dart';

import '../../../../core/network_info/network_info.dart';

class TownRepositoryImpl extends TownRepository {
  final TownRemoteSource townRemoteSource;
  final TownLocalSource townLocalSource;
  final NetworkInfo networkInfo;

  TownRepositoryImpl(
      {required this.townRemoteSource,
      required this.townLocalSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, TownModel>> getTown(GetTownParams params) {
    return ServiceRunner<TownModel>(networkInfo: networkInfo)
        .runNetworkTask(() => townRemoteSource.getTown(params));
  }
}

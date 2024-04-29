import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/state/data/models/state_model.dart';
import 'package:parish_aid_admin/features/state/data/sources/state_local_source.dart';
import 'package:parish_aid_admin/features/state/data/sources/state_remote_source.dart';
import 'package:parish_aid_admin/features/state/domain/repository/state_repository.dart';
import 'package:parish_aid_admin/features/state/domain/usecases/get_state.dart';

import '../../../../core/network_info/network_info.dart';

class StateRepositoryImpl extends StateRepository{

  final StateRemoteSource stateRemoteSource;
  final StateLocalSource stateLocalSource;
  final NetworkInfo networkInfo;

  StateRepositoryImpl({required this.stateRemoteSource,required this.stateLocalSource,required this.networkInfo});

  @override
  Future<Either<Failure, StateModel>> getState(GetStateParams params) {
    return ServiceRunner<StateModel>(networkInfo: networkInfo)
        .runNetworkTask(() => stateRemoteSource.getState(params));
  }
}
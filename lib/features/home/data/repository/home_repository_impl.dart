import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/network_info/network_info.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/data/sources/home_local_source.dart';
import 'package:parish_aid_admin/features/home/data/sources/home_remote_source.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/approve_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/create_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/delete_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_show.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/update_parish.dart';

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
  Future<Either<Failure, ParishModel>> getShow(GetShowParam param) {
    return ServiceRunner<ParishModel>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.getShow(param));
  }

  @override
  Future<Either<Failure, ParishModel>> updateParish(UpdateParishParams params) {
    return ServiceRunner<ParishModel>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.updateParish(params));
  }

  @override
  Future<Either<Failure, ParishModel>> createParish(CreateParishParams params) {
    return ServiceRunner<ParishModel>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.createParish(params));
  }

  @override
  Future<Either<Failure, ParishModel>> approveParish(ApproveParishParam param) {
    return ServiceRunner<ParishModel>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.approveParish(param));
  }

  @override
  Future<Either<Failure, bool>> deleteParish(DeleteParishParam param) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => homeRemoteSource.deleteParish(param));
  }
}

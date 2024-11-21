
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/group/data/model/get_group_model.dart';
import 'package:parish_aid_admin/features/group/data/model/group_admin_model.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';
import 'package:parish_aid_admin/features/group/data/sources/group_remote_sources.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/create_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/create_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/delete_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/delete_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_group_admins.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_groups.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/show_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/update_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/update_group_admin.dart';

import '../../../../core/network_info/network_info.dart';

class GroupRepositoryImpl extends GroupRepository{

  final GroupRemoteSource groupRemoteSource;
  final NetworkInfo networkInfo;

  GroupRepositoryImpl({
    required this.networkInfo,required this.groupRemoteSource
});

  @override
  Future<Either<Failure, GetGroupModel>> createGroup(CreateGroupParams params) {
    return ServiceRunner<GetGroupModel>(networkInfo: networkInfo)
        .runNetworkTask(() => groupRemoteSource.createGroup(params));
  }

  @override
  Future<Either<Failure, GetGroupModel>> updateGroup(UpdateGroupParams params) {

    return ServiceRunner<GetGroupModel>(networkInfo: networkInfo)
        .runNetworkTask(() => groupRemoteSource.updateGroup(params));
  }
  @override
  Future<Either<Failure, GetGroupModel>> getGroup(GetGroupParams params) {
    return ServiceRunner<GetGroupModel>(networkInfo: networkInfo)
        .runNetworkTask(() => groupRemoteSource.getGroup(params));
  }

  @override
  Future<Either<Failure, GroupModel>> getGroups(GetGroupsParams params) {
    return ServiceRunner<GroupModel>(networkInfo: networkInfo)
        .runNetworkTask(() => groupRemoteSource.getGroups(params));
  }

  @override
  Future<Either<Failure, bool>> deleteGroup(DeleteGroupParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => groupRemoteSource.deleteGroup(params));
  }

  @override
  Future<Either<Failure, GroupAdminModel>> updateGroupAdmin(UpdateGroupAdminParam params) {
    return ServiceRunner<GroupAdminModel>(networkInfo: networkInfo)
        .runNetworkTask(()=>groupRemoteSource.updateGroupAdmin(params));
  }

  @override
  Future<Either<Failure, List<GroupAdminData>>> getGroupAdmins(GetGroupAdminsParams params) {
    return ServiceRunner<List<GroupAdminData>>(networkInfo: networkInfo)
        .runNetworkTask(()=>groupRemoteSource.getGroupAdmins(params));
  }

  @override
  Future<Either<Failure, GroupAdminModel>> showGroupAdmin(ShowGroupAdminParams params) {
    return ServiceRunner<GroupAdminModel>(networkInfo: networkInfo)
        .runNetworkTask(()=>groupRemoteSource.showGroupAdmin(params));
  }

  @override
  Future<Either<Failure, bool>> deleteGroupAdmin(DeleteGroupAdminParams params) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(()=>groupRemoteSource.deleteGroupAdmin(params));
  }

  @override
  Future<Either<Failure, GroupAdminModel>> createGroupAdmin(CreateGroupAdminParams params) {
    return ServiceRunner<GroupAdminModel>(networkInfo: networkInfo)
        .runNetworkTask(()=>groupRemoteSource.createGroupAdmin(params));
  }
}
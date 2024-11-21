import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/features/group/data/model/get_group_model.dart';
import 'package:parish_aid_admin/features/group/data/model/group_admin_model.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/create_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/create_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/delete_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/delete_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/get_group_admins.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/show_group_admin.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/update_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/update_group_admin.dart';

import '../../../../core/failures/failure.dart';
import '../usecases/get_groups.dart';

abstract class GroupRepository{


  Future<Either<Failure, GetGroupModel>> createGroup(CreateGroupParams params);
  Future<Either<Failure,GetGroupModel>> updateGroup(UpdateGroupParams params);
  Future<Either<Failure,GetGroupModel>> getGroup(GetGroupParams params);
  Future<Either<Failure,GroupModel>> getGroups(GetGroupsParams params);
  Future<Either<Failure,bool>> deleteGroup(DeleteGroupParams params);
  Future<Either<Failure,GroupAdminModel>> updateGroupAdmin(UpdateGroupAdminParam params);
  Future<Either<Failure,List<GroupAdminData>>>getGroupAdmins(GetGroupAdminsParams params);
  Future<Either<Failure,GroupAdminModel>> showGroupAdmin(ShowGroupAdminParams params);
  Future<Either<Failure,bool>> deleteGroupAdmin(DeleteGroupAdminParams params);
  Future<Either<Failure,GroupAdminModel>> createGroupAdmin(CreateGroupAdminParams params);
}
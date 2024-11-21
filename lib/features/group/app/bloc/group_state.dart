import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/group/data/model/get_group_model.dart';
import 'package:parish_aid_admin/features/group/data/model/group_admin_model.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';

class GroupState extends Equatable{
  @override

  List<Object?> get props => [];

}
class GroupInitial extends GroupState{}
class CreateGroupLoading extends GroupState{

}

class CreateGroupLoaded extends GroupState{
  final GetGroupModel groupModel;
  CreateGroupLoaded(this.groupModel);
}
class CreateGroupError extends GroupState{
  final Failure failure;
  CreateGroupError(this.failure);
}
class UpdateGroupLoading extends GroupState{}
class UpdateGroupLoaded extends GroupState{
  final GetGroupModel groupModel;
  UpdateGroupLoaded(this.groupModel);
}
class UpdateGroupError extends GroupState{
  final Failure failure;
  UpdateGroupError(this.failure);
}
class GetGroupLoading extends GroupState{}
class GetGroupLoaded extends GroupState{
  final GetGroupModel groupModel;
  GetGroupLoaded(this.groupModel);
}
class GetGroupError extends GroupState{
  final Failure failure;
  GetGroupError(this.failure);
}
class GetGroupsLoading extends GroupState{}
class GetGroupsLoaded extends GroupState{
  final GroupModel groupModel;
  GetGroupsLoaded(this.groupModel);
}
class GetGroupsError extends GroupState{
  final Failure failure;
  GetGroupsError(this.failure);
}
class DeleteGroupLoading extends GroupState{}
class DeleteGroupLoaded extends GroupState{
  final bool status;
  DeleteGroupLoaded(this.status);
}
class DeleteGroupError extends GroupState{
  final Failure failure;
  DeleteGroupError(this.failure);
}

class UpdateGroupAdminLoading extends GroupState{}
class UpdateGroupAdminLoaded extends GroupState{
  final GroupAdminModel groupAdminModel;
  UpdateGroupAdminLoaded(this.groupAdminModel);
}
class UpdateGroupAdminError extends GroupState{
  final Failure failure;
  UpdateGroupAdminError(this.failure);
}

class GetGroupAdminsLoading extends GroupState{}
class GetGroupAdminsLoaded extends GroupState{
  final List<GroupAdminData> groupsData;
  GetGroupAdminsLoaded(this.groupsData);
}
class GetGroupAdminsError extends GroupState{
  final Failure failure;
  GetGroupAdminsError(this.failure);
}

class ShowGroupAdminLoading extends GroupState{
}
class ShowGroupAdminLoaded extends GroupState{
  final GroupAdminModel adminModel;
  ShowGroupAdminLoaded(this.adminModel);
}
class ShowGroupAdminError extends GroupState{
  final Failure failure;
  ShowGroupAdminError(this.failure);
}
class DeleteGroupAdminLoading extends GroupState{}
class DeleteGroupAdminLoaded extends GroupState{
  final bool status;
  DeleteGroupAdminLoaded(this.status);
}
class DeleteGroupAdminError extends GroupState{
  final Failure failure;
  DeleteGroupAdminError(this.failure);
}
class CreateGroupAdminLoading extends GroupState{
}
class CreateGroupAdminLoaded extends GroupState{
  final GroupAdminModel adminModel;
  CreateGroupAdminLoaded(this.adminModel);
}
class CreateGroupAdminError extends GroupState{
  final Failure failure;
  CreateGroupAdminError(this.failure);
}
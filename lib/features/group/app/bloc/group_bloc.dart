import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_event.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_state.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/create_group.dart';
import 'package:parish_aid_admin/features/group/domain/usecases/update_group.dart';

import '../../domain/usecases/create_group_admin.dart';
import '../../domain/usecases/delete_group.dart';
import '../../domain/usecases/delete_group_admin.dart';
import '../../domain/usecases/get_group.dart';
import '../../domain/usecases/get_group_admins.dart';
import '../../domain/usecases/get_groups.dart';
import '../../domain/usecases/show_group_admin.dart';
import '../../domain/usecases/update_group_admin.dart';

class GroupBloc extends Bloc<GroupEvent,GroupState>{
  final CreateGroup createGroup;
  final UpdateGroup updateGroup;
  final GetGroup getGroup;
  final GetGroups getGroups;
  final DeleteGroup deleteGroup;
  final UpdateGroupAdmin updateGroupAdmin;
  final GetGroupAdmins getGroupAdmins;
  final ShowGroupAdmin showGroupAdmin;
  final DeleteGroupAdmin deleteGroupAdmin;
  final CreateGroupAdmin createGroupAdmin;

  GroupBloc({required this.createGroup,required this.updateGroup,required this.getGroup,
    required this.getGroups,required this.deleteGroup,required this.updateGroupAdmin,
  required this.getGroupAdmins,required this.showGroupAdmin,required this.deleteGroupAdmin,
  required this.createGroupAdmin}) : super(GroupInitial()){
    on<GroupEvent>((event,emit)async{
      if(event is CreateGroupEvent){
        emit(CreateGroupLoading());

        final result = await createGroup(CreateGroupParams(
          name: event.name,
          acronym: event.acronym,
          email: event.email,
          phoneNo: event.phoneNo,
          address: event.address,
          stateId: event.stateId,
          lgaId: event.lgaId,
          town: event.town,
          parishId: event.parishId,
          registrarEmail: event.registrarEmail,
          password: event.password,
          category: event.category,
          logo: event.logo,
          coverImage: event.coverImage
        ));
        emit(result.fold((failure) => CreateGroupError(failure), (group) => CreateGroupLoaded(group)));
      }else if(event is UpdateGroupEvent){
        emit(UpdateGroupLoading());

        final result = await updateGroup(UpdateGroupParams(
          name: event.name,
          acronym: event.acronym,
          email: event.email,
          phoneNo: event.phoneNo,
          address: event.address,
          stateId: event.stateId,
          lgaId: event.lgaId,
          groupId: event.groupId,
          town: event.town,
          parishId: event.parishId,
          registrarEmail: event.registrarEmail,
          logo: event.logo,
          coverImage: event.coverImage
        ));
        emit(result.fold((failure) => UpdateGroupError(failure), (group) => UpdateGroupLoaded(group)));
      }else if(event is GetGroupEvent){
        emit(GetGroupLoading());

        final result = await getGroup(GetGroupParams(groupId: event.groupId, parishId: event.parishId));
        emit(result.fold((failure) => GetGroupError(failure), (group) => GetGroupLoaded(group)));
      }else if(event is GetGroupsEvent){
        emit(GetGroupsLoading());

        final result = await getGroups(GetGroupsParams(parish: event.parishId));
        emit(result.fold((failure) => GetGroupsError(failure), (groupModel) => GetGroupsLoaded(groupModel)));
      }else if(event is DeleteGroupEvent){
        emit(DeleteGroupLoading());

        final result = await deleteGroup(DeleteGroupParams(parishId: event.parishId, groupId: event.groupId));
        emit(result.fold((failure) => DeleteGroupError(failure), (status) => DeleteGroupLoaded(status)));
      }else if(event is UpdateGroupAdminEvent){
        emit(UpdateGroupAdminLoading());

        final result = await updateGroupAdmin(UpdateGroupAdminParam(
            group: event.group, parish: event.parish,
            admin: event.admin, email: event.email,
            name: event.name, role: event.role, groupId: event.groupId));

        emit(result.fold((failure)=>UpdateGroupAdminError(failure), (groupAdmin)=>UpdateGroupAdminLoaded(groupAdmin)));
      }else if(event is GetGroupAdminsEvent){
        emit(GetGroupAdminsLoading());

        final result  = await getGroupAdmins(GetGroupAdminsParams(event.parish, event.group));

        emit(result.fold((failure)=>GetGroupAdminsError(failure), (groupsData)=>GetGroupAdminsLoaded(groupsData)));
      }else if(event is ShowGroupAdminEvent){
        emit(ShowGroupAdminLoading());

        final result = await showGroupAdmin(ShowGroupAdminParams(event.parish, event.group, event.admin));

        emit(result.fold((failure)=>ShowGroupAdminError(failure), (adminModel)=>ShowGroupAdminLoaded(adminModel)));
      }else if(event is DeleteGroupAdminEvent){
        emit(DeleteGroupAdminLoading());

        final result = await deleteGroupAdmin(DeleteGroupAdminParams(event.parish, event.group, event.admin));

        emit(result.fold((failure)=>DeleteGroupAdminError(failure), (status)=>DeleteGroupAdminLoaded(status)));
      }else if(event is CreateGroupAdminEvent){
        emit(CreateGroupAdminLoading());

        final  result = await createGroupAdmin(CreateGroupAdminParams(event.email, event.name, event.role, event.group, event.parish));

        emit(result.fold((failure)=>CreateGroupAdminError(failure), (adminModel)=>CreateGroupAdminLoaded(adminModel)));
      }
    });
  }
}
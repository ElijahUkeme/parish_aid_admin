import 'package:equatable/equatable.dart';

class GroupEvent extends Equatable{
  @override
  List<Object?> get props => [];

}
class CreateGroupEvent extends GroupEvent{

  final String? name;
  final String? acronym;
  final String? email;
  final String? phoneNo;
  final String? address;
  final int? stateId;
  final int? lgaId;
  final String? town;
  final String? parishId;
  final String? registrarEmail;
  final String? password;
  final String? category;
  final String? logo;
  final String? coverImage;

  CreateGroupEvent({
    this.name,
    this.acronym,
    this.email,
    this.phoneNo,
    this.address,
    this.stateId,
    this.lgaId,
    this.town,
    this.parishId,
    this.registrarEmail,
    this.password,
    this.category,
    this.logo,
    this.coverImage
});
}

class UpdateGroupEvent extends GroupEvent{

  final String? name;
  final String? acronym;
  final String? email;
  final String? phoneNo;
  final String? address;
  final String? stateId;
  final String? lgaId;
  final String? groupId;
  final String? town;
  final String? parishId;
  final String? registrarEmail;
  final String? password;
  final String? category;
  final String? logo;
  final String? coverImage;

  UpdateGroupEvent({
    this.name,
    this.acronym,
    this.email,
    this.phoneNo,
    this.address,
    this.groupId,
    this.stateId,
    this.lgaId,
    this.town,
    this.parishId,
    this.registrarEmail,
    this.password,
    this.category,
    this.logo,
    this.coverImage
  });
}
class GetGroupEvent extends GroupEvent{
  final String? groupId;
  final String? parishId;

  GetGroupEvent({required this.groupId,required this.parishId});
}
class GetGroupsEvent extends GroupEvent{
  final String? parishId;
  GetGroupsEvent({required this.parishId});
}
class DeleteGroupEvent extends GroupEvent{
  final String groupId;
  final String parishId;
  DeleteGroupEvent({required this.parishId,required this.groupId});
}
class UpdateGroupAdminEvent extends GroupEvent{
  final int group;
  final int parish;
  final int admin;
  final String email;
  final String name;
  final String role;
  final int groupId;

  UpdateGroupAdminEvent({required this.group,required this.parish,required this.admin,
    required this.email,required this.name,required this.role,required this.groupId});

}
class GetGroupAdminsEvent extends GroupEvent{
  final int? parish;
  final int? group;
  GetGroupAdminsEvent(this.parish,this.group);
}
class ShowGroupAdminEvent extends GroupEvent{
  final int? parish;
  final int? group;
  final int? admin;

  ShowGroupAdminEvent(this.parish,this.group,this.admin);
}

class DeleteGroupAdminEvent extends GroupEvent{
  final int? parish;
  final int? group;
  final int? admin;

  DeleteGroupAdminEvent(this.parish,this.group,this.admin);
}
class CreateGroupAdminEvent extends GroupEvent{
  final int? group;
  final int? parish;
  final String? email;
  final String? name;
  final String? role;

  CreateGroupAdminEvent(this.group,this.parish,this.email,this.name,this.role);
}
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/group/data/model/group_admin_model.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';

class UpdateGroupAdmin extends Usecase<GroupAdminModel,UpdateGroupAdminParam>{
  final GroupRepository groupRepository;
  UpdateGroupAdmin(this.groupRepository);

  @override
  Future<Either<Failure, GroupAdminModel>> call(UpdateGroupAdminParam params) {
   return groupRepository.updateGroupAdmin(params);
  }
}

class UpdateGroupAdminParam extends Equatable{
   final int group;
   final int parish;
   final int admin;
   final String email;
   final String name;
   final String role;
   final int groupId;

   const UpdateGroupAdminParam({required this.group,required this.parish,required this.admin,
     required this.email,required this.name,required this.role,required this.groupId});

  @override
  List<Object?> get props => [];
}
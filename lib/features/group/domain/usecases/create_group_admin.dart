import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/group/data/model/group_admin_model.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';

class CreateGroupAdmin extends Usecase<GroupAdminModel,CreateGroupAdminParams>{

  final GroupRepository groupRepository;
  CreateGroupAdmin(this.groupRepository);

  @override
  Future<Either<Failure, GroupAdminModel>> call(CreateGroupAdminParams params) {
    return groupRepository.createGroupAdmin(params);
  }
}
class CreateGroupAdminParams extends Equatable{
  final String? email;
  final String? name;
  final String? role;
  final int? group;
  final int? parish;

  const CreateGroupAdminParams(this.email,this.name,this.role,this.group,this.parish);

  @override
  List<Object?> get props => [];
}
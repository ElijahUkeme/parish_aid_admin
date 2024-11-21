import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';

class DeleteGroupAdmin extends Usecase<bool,DeleteGroupAdminParams>{
  final GroupRepository groupRepository;

  DeleteGroupAdmin(this.groupRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteGroupAdminParams params) {
    return groupRepository.deleteGroupAdmin(params);
  }
}

class DeleteGroupAdminParams extends Equatable{
  final int? parish;
  final int? group;
  final int? admin;

  const DeleteGroupAdminParams(this.parish,this.group,this.admin);

  @override
  List<Object?> get props => [];
}
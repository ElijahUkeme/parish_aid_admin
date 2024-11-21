import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';

class DeleteGroup extends Usecase<bool,DeleteGroupParams>{
  final GroupRepository groupRepository;
  DeleteGroup(this.groupRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteGroupParams params) {
    return groupRepository.deleteGroup(params);
  }
}

class DeleteGroupParams extends Equatable{
  final String parishId;
  final String groupId;
  const DeleteGroupParams({required this.parishId,required this.groupId});

  @override
  List<Object?> get props => [];
}


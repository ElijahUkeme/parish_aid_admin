import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/group/data/model/group_admin_model.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';

class GetGroupAdmins extends Usecase<List<GroupAdminData>,GetGroupAdminsParams>{
  final GroupRepository groupRepository;
  GetGroupAdmins(this.groupRepository);

  @override
  Future<Either<Failure, List<GroupAdminData>>> call(GetGroupAdminsParams params) {
    return groupRepository.getGroupAdmins(params);
  }

}

class GetGroupAdminsParams extends Equatable{
  final int? parish;
  final int? group;

  const GetGroupAdminsParams(this.parish,this.group);

  @override
  List<Object?> get props => [];
}
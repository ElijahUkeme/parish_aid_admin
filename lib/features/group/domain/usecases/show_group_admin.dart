import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/group/data/model/group_admin_model.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';

class ShowGroupAdmin extends Usecase<GroupAdminModel,ShowGroupAdminParams>{
  final GroupRepository groupRepository;
  ShowGroupAdmin(this.groupRepository);

  @override
  Future<Either<Failure, GroupAdminModel>> call(ShowGroupAdminParams params) {
    return groupRepository.showGroupAdmin(params);
  }
}

class ShowGroupAdminParams extends Equatable{
  final int? parish;
  final int? group;
  final int? admin;

  const ShowGroupAdminParams(this.parish,this.group,this.admin);

  @override
  List<Object?> get props => [];
}
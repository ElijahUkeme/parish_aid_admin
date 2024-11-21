import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/group/data/model/get_group_model.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';

import '../repository/group_repository.dart';

class UpdateGroup extends Usecase<GetGroupModel,UpdateGroupParams>{
  final GroupRepository groupRepository;
  UpdateGroup(this.groupRepository);

  @override
  Future<Either<Failure, GetGroupModel>> call(UpdateGroupParams params) {
    return groupRepository.updateGroup(params);
  }

}

class UpdateGroupParams extends Equatable {
  final String? name;
  final String? acronym;
  final String? email;
  final String? phoneNo;
  final String? address;
  final String? stateId;
  final String? lgaId;
  final String? town;
  final String? parishId;
  final String? groupId;
  final String? registrarEmail;
  final String? logo;
  final String? coverImage;

  const UpdateGroupParams({
    this.name,
    this.acronym,
    this.email,
    this.phoneNo,
    this.address,
    this.stateId,
    this.lgaId,
    this.town,
    this.parishId,
    this.groupId,
    this.registrarEmail,
    this.logo,
    this.coverImage
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/group/data/model/get_group_model.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';

class CreateGroup extends Usecase<GetGroupModel,CreateGroupParams>{
  final GroupRepository groupRepository;
  CreateGroup(this.groupRepository);

  @override
  Future<Either<Failure, GetGroupModel>> call(CreateGroupParams params) {
    return groupRepository.createGroup(params);
  }
}

class CreateGroupParams extends Equatable{
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

  const CreateGroupParams({
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

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
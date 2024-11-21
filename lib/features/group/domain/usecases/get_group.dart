import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/group/data/model/get_group_model.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';

class GetGroup extends Usecase<GetGroupModel,GetGroupParams>{
  final GroupRepository groupRepository;
  GetGroup(this.groupRepository);

  @override
  Future<Either<Failure, GetGroupModel>> call(GetGroupParams params) {
    return groupRepository.getGroup(params);
  }

}

class GetGroupParams extends Equatable{
  final String? groupId;
  final String? parishId;
  const GetGroupParams({required this.groupId,required this.parishId});

  @override
  List<Object?> get props => [];
}
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';
import 'package:parish_aid_admin/features/group/domain/repository/group_repository.dart';

class GetGroups extends Usecase<GroupModel,GetGroupsParams>{
  final GroupRepository groupRepository;
  GetGroups(this.groupRepository);

  @override
  Future<Either<Failure, GroupModel>> call(GetGroupsParams params) {
   return groupRepository.getGroups(params);
  }

}
class GetGroupsParams extends Equatable{
  final String? parish;
  const GetGroupsParams({required this.parish});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_list_model.dart';
import 'package:parish_aid_admin/features/parishioner/domain/repository/parishioner_repository.dart';

class GetParishioners extends Usecase<ParishionerListModel,GetParishionersParam>{
  final ParishionerRepository parishionerRepository;

  GetParishioners(this.parishionerRepository);

  @override
  Future<Either<Failure, ParishionerListModel>> call(GetParishionersParam params) {
    return parishionerRepository.getParishioners(params);
  }
}
class GetParishionersParam extends Equatable{
  final String? parish;
  const GetParishionersParam(this.parish);

  @override
  List<Object?> get props => [];
}
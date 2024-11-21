import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_model.dart';
import 'package:parish_aid_admin/features/parishioner/domain/repository/parishioner_repository.dart';

class GetParishioner extends Usecase<ParishionerModel,GetParishionerParams>{
  final ParishionerRepository parishionerRepository;
  GetParishioner(this.parishionerRepository);

  @override
  Future<Either<Failure, ParishionerModel>> call(GetParishionerParams params) {
    return parishionerRepository.getParishioner(params);
  }
}

class GetParishionerParams extends Equatable{
  final String? parish;
  final String? parishioner;

  const GetParishionerParams(this.parish,this.parishioner);

  @override

  List<Object?> get props => [];
}
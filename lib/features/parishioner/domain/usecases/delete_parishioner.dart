import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/parishioner/domain/repository/parishioner_repository.dart';

class DeleteParishioner extends Usecase<bool,DeleteParishionerParams>{
  final ParishionerRepository parishionerRepository;

  DeleteParishioner(this.parishionerRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteParishionerParams params) {
    return parishionerRepository.deleteParishioner(params);
  }
}

class DeleteParishionerParams extends Equatable{
  final String? parish;
  final String? parishioner;

  const DeleteParishionerParams(this.parish,this.parishioner);

  @override

  List<Object?> get props => [];
}
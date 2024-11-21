import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/state/data/models/state_model.dart';
import 'package:parish_aid_admin/features/state/domain/repository/state_repository.dart';

class GetState extends Usecase<StateModel,GetStatesParams>{
  final StateRepository stateRepository;

  GetState({required this.stateRepository});
  @override
  Future<Either<Failure, StateModel>> call(GetStatesParams params) {
    return stateRepository.getState(params);
  }
}

class GetStatesParams extends Equatable{
  final int countryId;

  const GetStatesParams({required this.countryId});

  @override

  List<Object?> get props => [];
}
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/state/data/models/state_model.dart';
import 'package:parish_aid_admin/features/state/domain/repository/state_repository.dart';

class GetState extends Usecase<StateModel,GetStateParams>{
  final StateRepository stateRepository;

  GetState({required this.stateRepository});
  @override
  Future<Either<Failure, StateModel>> call(GetStateParams params) {
    return stateRepository.getState(params);
  }
}

class GetStateParams extends Equatable{
  final int stateId;

  const GetStateParams({required this.stateId});

  @override

  List<Object?> get props => [];
}
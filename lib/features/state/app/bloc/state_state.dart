import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/state/data/models/state_model.dart';

class StateState extends Equatable{
  @override
  List<Object?> get props => [];
}
class GetStatesInitial extends StateState{}
class GetStatesLoading extends StateState{}
class GetStatesLoaded extends StateState{
  final StateModel stateModel;

  GetStatesLoaded(this.stateModel);
}
class GetStatesError extends StateState{
  final Failure failure;
  GetStatesError(this.failure);
}
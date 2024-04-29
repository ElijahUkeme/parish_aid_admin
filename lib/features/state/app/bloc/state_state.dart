import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/state/data/models/state_model.dart';

class StateState extends Equatable{
  @override
  List<Object?> get props => [];
}
class GetStateInitial extends StateState{}
class GetStateLoading extends StateState{}
class GetStateLoaded extends StateState{
  final StateModel stateModel;

  GetStateLoaded(this.stateModel);
}
class GetStateError extends StateState{
  final Failure failure;
  GetStateError(this.failure);
}
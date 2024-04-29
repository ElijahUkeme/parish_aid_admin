import 'package:equatable/equatable.dart';

class StateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetStateByStateIdEvent extends StateEvent {
  final int stateId;

  GetStateByStateIdEvent(this.stateId);
}

import 'package:equatable/equatable.dart';

class StateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetStatesByCountryIdEvent extends StateEvent {
  final int countryId;

  GetStatesByCountryIdEvent(this.countryId);
}

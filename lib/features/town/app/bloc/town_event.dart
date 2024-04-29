import 'package:equatable/equatable.dart';

class TownEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTownEvent extends TownEvent {
  final String searchKey;
  final int countryId;
  final int stateId;
  final int lgaId;

  GetTownEvent(this.searchKey, this.countryId, this.stateId, this.lgaId);
}

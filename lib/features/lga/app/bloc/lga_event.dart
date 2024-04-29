import 'package:equatable/equatable.dart';

class LgaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLgaEvent extends LgaEvent {
  final int countryId;
  final int stateId;

  GetLgaEvent(this.countryId, this.stateId);
}

import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetParishesEvent extends HomeEvent {}

class GetShowEvent extends HomeEvent {
  final int parish;
  GetShowEvent({required this.parish});
}

class UpdateParishEvent extends HomeEvent {
  final String? name;
  final String? acronym;
  final String? email;
  final String? phoneNo;
  final String? address;
  final int? dioceseId;
  final int? stateId;
  final int? lgaId;
  final String? town;
  final String? parishPriestName;
  final String? password;
  final String? registrarEmail;
  final String? logo;
  final String? coverImage;
  final int? parishId;

  UpdateParishEvent(
      {this.name,
      this.acronym,
      this.email,
      this.phoneNo,
      this.address,
      this.dioceseId,
      this.stateId,
      this.lgaId,
      this.town,
      this.parishPriestName,
      this.password,
      this.registrarEmail,
      this.logo,
      this.coverImage,
      this.parishId});
}

class CreateParishEvent extends HomeEvent {
  final String? name;
  final String? acronym;
  final String? email;
  final String? phoneNo;
  final String? address;
  final String? dioceseId;
  final String? stateId;
  final String? lgaId;
  final String? town;
  final String? parishPriestName;
  final String? password;
  final String? registrarEmail;
  final String? logo;
  final String? coverImage;

  CreateParishEvent(
      {this.name,
      this.acronym,
      this.email,
      this.phoneNo,
      this.address,
      this.dioceseId,
      this.stateId,
      this.lgaId,
      this.town,
      this.parishPriestName,
      this.password,
      this.registrarEmail,
      this.logo,
      this.coverImage});
}

class ApproveParishEvent extends HomeEvent {
  final int parish;
  ApproveParishEvent(this.parish);
}

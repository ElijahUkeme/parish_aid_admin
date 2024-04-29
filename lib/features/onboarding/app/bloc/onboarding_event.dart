import 'package:equatable/equatable.dart';

class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterParishEvent extends OnboardingEvent {
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

  RegisterParishEvent(
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

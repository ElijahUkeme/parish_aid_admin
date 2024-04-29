import 'package:equatable/equatable.dart';

class ParishUpdate extends Equatable {
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

  const ParishUpdate(
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

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

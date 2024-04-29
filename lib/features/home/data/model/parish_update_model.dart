import 'package:parish_aid_admin/features/home/domain/entities/parish_update.dart';

class UpdateParishModel extends ParishUpdate {
  @override
  final String? name;
  @override
  final String? acronym;
  @override
  final String? email;
  @override
  final String? phoneNo;
  @override
  final String? address;
  @override
  final int? dioceseId;
  @override
  final int? stateId;
  @override
  final int? lgaId;
  @override
  final String? town;
  @override
  final String? parishPriestName;
  @override
  final String? password;
  @override
  final String? registrarEmail;
  @override
  final String? logo;
  @override
  final String? coverImage;
  @override
  final int? parishId;

  const UpdateParishModel(
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['acronym'] = acronym;
    data['acronym'] = email;
    data['phone_no'] = phoneNo;
    data['address'] = address;
    data['diocese_id'] = dioceseId;
    data['diocese_id'] = stateId;
    data['lga_id'] = lgaId;
    data['town'] = town;
    data['parish_priest_name'] = parishPriestName;
    data['password'] = password;
    data['registrar_email'] = registrarEmail;
    data['logo'] = logo;
    data['cover_image'] = coverImage;

    return data;
  }
}

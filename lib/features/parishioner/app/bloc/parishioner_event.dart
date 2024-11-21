import 'package:equatable/equatable.dart';

class ParishionerEvent extends Equatable{
  @override
  List<Object?> get props => [];

}
class CreateParishionerEvent extends ParishionerEvent{

  final String? name;
  final String? email;
  final String? phoneNo;
  final String? gender;
  final String? whatsAppNo;
  final String? dob;
  final String? employmentStatus;
  final String? address;
  final String? employerName;
  final String? school;
  final int? stateId;
  final int? lgaId;
  final String? town;
  final String? parishId;
  final String? groupId;
  final String? image;

  CreateParishionerEvent(
      this.name,
      this.email,
      this.phoneNo,
      this.gender,
      this.whatsAppNo,
      this.dob,
      this.employmentStatus,
      this.address,
      this.employerName,
      this.school,
      this.stateId,
      this.lgaId,
      this.town,
      this.parishId,
      this.groupId,
      this.image
      );
}
class UpdateParishionerEvent extends ParishionerEvent{

  final String? name;
  final String? email;
  final String? phoneNo;
  final String? gender;
  final String? whatsAppNo;
  final String? dob;
  final String? employmentStatus;
  final String? address;
  final String? employerName;
  final String? school;
  final String? stateId;
  final String? lgaId;
  final String? town;
  final String? parishId;
  final String? groupId;
  final String? image;
  final String? parishioner;

  UpdateParishionerEvent(

      this.name,
      this.email,
      this.phoneNo,
      this.gender,
      this.whatsAppNo,
      this.dob,
      this.employmentStatus,
      this.address,
      this.employerName,
      this.school,
      this.stateId,
      this.lgaId,
      this.town,
      this.parishId,
      this.groupId,
      this.image,
      this.parishioner
      );
}
class GetParishionersEvent extends ParishionerEvent{
  final String? parish;
  GetParishionersEvent(this.parish);
}
class GetParishionerEvent extends ParishionerEvent{
  final String? parish;
  final String? parishioner;

  GetParishionerEvent(this.parish,this.parishioner);
}

class DeleteParishionerEvent extends ParishionerEvent{
  final String? parish;
  final String? parishioner;

  DeleteParishionerEvent(this.parish,this.parishioner);
}
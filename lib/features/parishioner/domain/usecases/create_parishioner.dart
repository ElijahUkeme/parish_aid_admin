import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_model.dart';
import 'package:parish_aid_admin/features/parishioner/domain/repository/parishioner_repository.dart';

class CreateParishioner extends Usecase<ParishionerModel,CreateParishionerParams>{
  final ParishionerRepository parishionerRepository;
  CreateParishioner(this.parishionerRepository);

  @override
  Future<Either<Failure, ParishionerModel>> call(CreateParishionerParams params) {
    return parishionerRepository.createParishioner(params);
  }
}

class CreateParishionerParams extends Equatable{
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

  const CreateParishionerParams({
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
});

  @override
  List<Object?> get props => [];
}
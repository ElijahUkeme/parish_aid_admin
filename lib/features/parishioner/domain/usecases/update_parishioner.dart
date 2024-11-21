
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_model.dart';
import 'package:parish_aid_admin/features/parishioner/domain/repository/parishioner_repository.dart';

class UpdateParishioner extends Usecase<ParishionerModel,UpdateParishionerParams> {
  final ParishionerRepository parishionerRepository;
  UpdateParishioner(this.parishionerRepository);

  @override
  Future<Either<Failure, ParishionerModel>> call(UpdateParishionerParams params) {
    return parishionerRepository.updateParishioner(params);
  }

}

class UpdateParishionerParams extends Equatable{

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

  const UpdateParishionerParams({
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
  });

  @override
  List<Object?> get props => [];
}


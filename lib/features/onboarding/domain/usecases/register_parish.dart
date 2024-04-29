import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/onboarding/domain/repository/onboarding_repository.dart';

class RegisterParish extends Usecase<ParishModel, RegisterParishParams> {
  final OnboardingRepository onboardingRepository;
  RegisterParish(this.onboardingRepository);

  @override
  Future<Either<Failure, ParishModel>> call(RegisterParishParams params) {
    return onboardingRepository.registerParish(params);
  }
}

class RegisterParishParams extends Equatable {
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

  const RegisterParishParams(
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

  @override
  List<Object?> get props => [];
}

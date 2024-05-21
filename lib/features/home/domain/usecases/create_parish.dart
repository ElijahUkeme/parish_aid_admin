import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class CreateParish extends Usecase<ParishModel, CreateParishParams> {
  final HomeRepository homeRepository;
  CreateParish(this.homeRepository);

  @override
  Future<Either<Failure, ParishModel>> call(CreateParishParams params) {
    return homeRepository.createParish(params);
  }
}

class CreateParishParams extends Equatable {
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

  const CreateParishParams(
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

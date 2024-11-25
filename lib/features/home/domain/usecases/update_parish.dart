import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/get_parish_model.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class UpdateParish extends Usecase<GetParishModel, UpdateParishParams> {
  final HomeRepository homeRepository;
  UpdateParish(this.homeRepository);

  @override
  Future<Either<Failure, GetParishModel>> call(UpdateParishParams params) {
    return homeRepository.updateParish(params);
  }
}

class UpdateParishParams extends Equatable {
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
  final String? parishId;

  const UpdateParishParams(
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
  List<Object?> get props => [];
}

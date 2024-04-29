import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/lga/data/models/lga_model.dart';
import 'package:parish_aid_admin/features/lga/domain/repository/lga_repository.dart';

class GetLga extends Usecase<LgaModel, GetLgaParams> {
  final LgaRepository lgaRepository;
  GetLga({required this.lgaRepository});

  @override
  Future<Either<Failure, LgaModel>> call(GetLgaParams params) {
    return lgaRepository.getLga(params);
  }
}

class GetLgaParams extends Equatable {
  final int countryId;
  final int stateId;

  const GetLgaParams({required this.countryId, required this.stateId});

  @override
  List<Object?> get props => [];
}

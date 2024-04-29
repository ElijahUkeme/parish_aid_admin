import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/town/data/models/town_model.dart';
import 'package:parish_aid_admin/features/town/domain/repository/town_repository.dart';

class GetTown extends Usecase<TownModel, GetTownParams> {
  final TownRepository townRepository;

  GetTown({required this.townRepository});

  @override
  Future<Either<Failure, TownModel>> call(GetTownParams params) {
    return townRepository.getTown(params);
  }
}

class GetTownParams extends Equatable {
  final String searchKey;
  final int countryId;
  final int stateId;
  final int lgaId;

  const GetTownParams(this.searchKey, this.countryId, this.stateId, this.lgaId);

  @override
  List<Object?> get props => [];
}

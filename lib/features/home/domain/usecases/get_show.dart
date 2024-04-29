import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class GetShow extends Usecase<ParishModel, GetShowParam> {
  final HomeRepository homeRepository;
  GetShow(this.homeRepository);

  @override
  Future<Either<Failure, ParishModel>> call(GetShowParam params) {
    return homeRepository.getShow(params);
  }
}

class GetShowParam extends Equatable {
  final int parish;
  const GetShowParam({required this.parish});

  @override
  List<Object?> get props => [];
}

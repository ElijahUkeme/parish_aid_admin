import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/diocese/data/models/diocese_model.dart';
import 'package:parish_aid_admin/features/diocese/domain/repository/diocese_repository.dart';

class ShowDiocese extends Usecase<DioceseModel, ShowDioceseParams> {
  final DioceseRepository dioceseRepository;

  ShowDiocese({required this.dioceseRepository});
  @override
  Future<Either<Failure, DioceseModel>> call(ShowDioceseParams params) {
    return dioceseRepository.showDiocese(params);
  }
}

class ShowDioceseParams extends Equatable {
  final int dioceseId;
  const ShowDioceseParams({required this.dioceseId});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

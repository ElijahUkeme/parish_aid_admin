import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/diocese/data/models/diocese_model.dart';
import 'package:parish_aid_admin/features/diocese/domain/repository/diocese_repository.dart';

class GetDiocese extends Usecase<DioceseModel,NoParams>{
  final DioceseRepository dioceseRepository;

  GetDiocese(this.dioceseRepository);

  @override
  Future<Either<Failure, DioceseModel>> call(params) {
    return dioceseRepository.getDioceses();
  }
}
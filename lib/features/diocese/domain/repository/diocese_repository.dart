import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/diocese/data/models/diocese_model.dart';
import 'package:parish_aid_admin/features/diocese/domain/usecases/show_diocese.dart';

abstract class DioceseRepository {
  Future<Either<Failure, DioceseModel>> getDioceses();
  Future<Either<Failure, DioceseModel>> showDiocese(ShowDioceseParams params);
}

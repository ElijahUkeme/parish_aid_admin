import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/lga/data/models/lga_model.dart';
import 'package:parish_aid_admin/features/lga/domain/usecases/get_lga.dart';

abstract class LgaRepository {
  Future<Either<Failure, LgaModel>> getLga(GetLgaParams params);
}

import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/town/domain/usecases/get_town.dart';

import '../../data/models/town_model.dart';

abstract class TownRepository {
  Future<Either<Failure, TownModel>> getTown(GetTownParams params);
}

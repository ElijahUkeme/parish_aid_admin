import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/onboarding/domain/usecases/register_parish.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, ParishModel>> registerParish(
      RegisterParishParams params);
}

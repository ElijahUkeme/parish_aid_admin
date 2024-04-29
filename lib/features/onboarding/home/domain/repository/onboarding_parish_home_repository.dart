import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/features/onboarding/home/domain/usecases/get_onboarding_parish_by_uid.dart';

import '../../../../../core/failures/failure.dart';
import '../../../../home/data/model/parish_model.dart';

abstract class OnBoardingParishHomeRepository {
  Future<Either<Failure, ParishModel>> getOnboardingParish();
  Future<Either<Failure, ParishModel>> getOnboardingParishByUid(
      GetOnboardingParishByUidParams params);
}

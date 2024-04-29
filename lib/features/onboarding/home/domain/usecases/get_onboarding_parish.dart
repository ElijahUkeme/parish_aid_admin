import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/onboarding/home/domain/repository/onboarding_parish_home_repository.dart';

class GetOnboardingParish extends Usecase<ParishModel, NoParams> {
  final OnBoardingParishHomeRepository onBoardingParishHomeRepository;
  GetOnboardingParish(this.onBoardingParishHomeRepository);

  @override
  Future<Either<Failure, ParishModel>> call(params) {
    return onBoardingParishHomeRepository.getOnboardingParish();
  }
}

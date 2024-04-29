import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';

import '../repository/onboarding_parish_home_repository.dart';

class GetOnboardingParishByUid
    extends Usecase<ParishModel, GetOnboardingParishByUidParams> {
  final OnBoardingParishHomeRepository onBoardingParishHomeRepository;

  GetOnboardingParishByUid(this.onBoardingParishHomeRepository);

  @override
  Future<Either<Failure, ParishModel>> call(
      GetOnboardingParishByUidParams params) {
    return onBoardingParishHomeRepository.getOnboardingParishByUid(params);
  }
}

class GetOnboardingParishByUidParams extends Equatable {
  final String uuid;
  const GetOnboardingParishByUidParams({required this.uuid});

  @override
  List<Object?> get props => [];
}

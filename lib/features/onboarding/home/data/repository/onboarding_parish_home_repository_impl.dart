import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/onboarding/home/data/sources/onboarding_parish_home_local_source.dart';
import 'package:parish_aid_admin/features/onboarding/home/data/sources/onboarding_parish_home_remote_source.dart';
import 'package:parish_aid_admin/features/onboarding/home/domain/repository/onboarding_parish_home_repository.dart';
import 'package:parish_aid_admin/features/onboarding/home/domain/usecases/get_onboarding_parish_by_uid.dart';

import '../../../../../core/network_info/network_info.dart';

class OnboardingParishHomeRepositoryImpl
    extends OnBoardingParishHomeRepository {
  final OnboardingParishHomeRemoteSource onboardingParishHomeRemoteSource;
  final OnboardingParishHomeLocalSource onboardingParishHomeLocalSource;
  final NetworkInfo networkInfo;

  OnboardingParishHomeRepositoryImpl(
      {required this.onboardingParishHomeRemoteSource,
      required this.onboardingParishHomeLocalSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, ParishModel>> getOnboardingParish() {
    return ServiceRunner<ParishModel>(networkInfo: networkInfo).runNetworkTask(
        () => onboardingParishHomeRemoteSource.getOnboardingParish());
  }

  @override
  Future<Either<Failure, ParishModel>> getOnboardingParishByUid(
      GetOnboardingParishByUidParams params) {
    return ServiceRunner<ParishModel>(networkInfo: networkInfo).runNetworkTask(
        () =>
            onboardingParishHomeRemoteSource.getOnboardingParishByUid(params));
  }
}

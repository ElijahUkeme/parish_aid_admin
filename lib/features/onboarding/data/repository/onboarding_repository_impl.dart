import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/onboarding/data/sources/onboarding_local_source.dart';
import 'package:parish_aid_admin/features/onboarding/data/sources/onboarding_remote_source.dart';
import 'package:parish_aid_admin/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:parish_aid_admin/features/onboarding/domain/usecases/register_parish.dart';

import '../../../../core/network_info/network_info.dart';

class OnboardingRepositoryImpl extends OnboardingRepository {
  final OnboardingRemoteSource onboardingRemoteSource;
  final OnboardingLocalSource onboardingLocalSource;
  final NetworkInfo networkInfo;

  OnboardingRepositoryImpl(
      {required this.onboardingRemoteSource,
      required this.onboardingLocalSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, ParishModel>> registerParish(
      RegisterParishParams params) {
    return ServiceRunner<ParishModel>(networkInfo: networkInfo)
        .runNetworkTask(() => onboardingRemoteSource.registerParish(params));
  }
}

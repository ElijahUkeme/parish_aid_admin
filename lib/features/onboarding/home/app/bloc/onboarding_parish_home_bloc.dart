import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/onboarding/home/app/bloc/onboarding_parish_home_event.dart';
import 'package:parish_aid_admin/features/onboarding/home/domain/usecases/get_onboarding_parish.dart';

import '../../domain/usecases/get_onboarding_parish_by_uid.dart';
import 'onboarding_parish_home_state.dart';

class OnboardingParishHomeBloc
    extends Bloc<OnboardingParishHomeEvent, OnboardingParishHomeState> {
  final GetOnboardingParish getOnboardingParish;
  final GetOnboardingParishByUid getOnboardingParishByUid;
  OnboardingParishHomeBloc(
      {required this.getOnboardingParish,
      required this.getOnboardingParishByUid})
      : super(OnboardingParishHomeInitial()) {
    on<OnboardingParishHomeEvent>(event, emit) async {
      if (event is GetOnboardingParishHomeEvent) {
        emit(GetOnBoardingParishHomeLoading());

        final result = await getOnboardingParish(NoParams());
        emit(result.fold((failure) => GetOnboardingParishHomeError(failure),
            (parish) => GetOnboardingParishHomeLoaded(parish)));
      } else if (event is GetOnboardingParishByUidEvent) {
        emit(GetOnboardingParishByUidLoading());

        final result = await getOnboardingParishByUid(
            GetOnboardingParishByUidParams(uuid: event.uuid));
        emit(result.fold((failure) => GetOnboardingParishByUidError(failure),
            (parish) => GetOnboardingParishByUidLoaded(parish)));
      }
    }
  }
}

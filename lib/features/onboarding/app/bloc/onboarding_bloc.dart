import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/onboarding/app/bloc/onboarding_event.dart';
import 'package:parish_aid_admin/features/onboarding/app/bloc/onboarding_state.dart';
import 'package:parish_aid_admin/features/onboarding/domain/usecases/register_parish.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final RegisterParish registerParish;

  OnboardingBloc({required this.registerParish}) : super(OnboardingInitial()) {
    on<OnboardingEvent>(event, emit) async {
      if (event is RegisterParishEvent) {
        emit(RegisterParishLoading());

        final result = await registerParish(RegisterParishParams(
            name: event.name,
            acronym: event.acronym,
            email: event.email,
            phoneNo: event.phoneNo,
            address: event.address,
            dioceseId: event.dioceseId,
            stateId: event.stateId,
            lgaId: event.lgaId,
            town: event.town,
            parishPriestName: event.parishPriestName,
            password: event.password,
            registrarEmail: event.registrarEmail,
            logo: event.logo,
            coverImage: event.coverImage));
        emit(result.fold((failure) => RegisterParishError(failure),
            (parish) => RegisterParishLoaded(parish)));
      }
    }
  }
}

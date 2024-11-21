import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_event.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_state.dart';

import '../../domain/usecases/get_state.dart';

class StateBloc extends Bloc<StateEvent, StateState> {
  final GetState getState;

  StateBloc({required this.getState}) : super(GetStatesInitial()) {
    on<StateEvent>((event, emit) async {
      if (event is GetStatesByCountryIdEvent) {
        emit(GetStatesLoading());

        final result = await getState(GetStatesParams(countryId: event.countryId));

        emit(result.fold((failure) => GetStatesError(failure),
            (states) => GetStatesLoaded(states)));
      }
    });
  }
}

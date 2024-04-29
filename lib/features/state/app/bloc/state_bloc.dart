import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_event.dart';
import 'package:parish_aid_admin/features/state/app/bloc/state_state.dart';

import '../../domain/usecases/get_state.dart';

class StateBloc extends Bloc<StateEvent, StateState> {
  final GetState getState;

  StateBloc({required this.getState}) : super(GetStateInitial()) {
    on<StateEvent>(event, emit) async {
      if (event is GetStateByStateIdEvent) {
        emit(GetStateLoading());

        final result = await getState(GetStateParams(stateId: event.stateId));

        emit(result.fold((failure) => GetStateError(failure),
            (states) => GetStateLoaded(states)));
      }
    }
  }
}

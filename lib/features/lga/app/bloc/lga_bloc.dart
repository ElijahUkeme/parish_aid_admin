import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/lga/app/bloc/lga_event.dart';
import 'package:parish_aid_admin/features/lga/app/bloc/lga_state.dart';
import 'package:parish_aid_admin/features/lga/domain/usecases/get_lga.dart';

class LgaBloc extends Bloc<LgaEvent, LgaState> {
  final GetLga getLga;

  LgaBloc({required this.getLga}) : super(LgaInitial()) {
    on<LgaEvent>(event, emit) async {
      if (event is GetLgaEvent) {
        emit(LgaLoading());

        final result = await getLga(
            GetLgaParams(countryId: event.countryId, stateId: event.stateId));
        emit(result.fold(
            (failure) => LgaError(failure), (lga) => LgaLoaded(lga)));
      }
    }
  }
}

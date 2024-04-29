import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/town/app/bloc/town_event.dart';
import 'package:parish_aid_admin/features/town/app/bloc/town_state.dart';
import 'package:parish_aid_admin/features/town/domain/usecases/get_town.dart';

class TownBloc extends Bloc<TownEvent, TownState> {
  final GetTown getTown;

  TownBloc({required this.getTown}) : super(TownInitial()) {
    on<TownEvent>(event, emit) async {
      if (event is GetTownEvent) {
        emit(GetTownLoading());

        final result = await getTown(GetTownParams(
            event.searchKey, event.countryId, event.stateId, event.lgaId));

        emit(result.fold(
            (failure) => GetTownError(failure), (town) => GetTownLoaded(town)));
      }
    }
  }
}

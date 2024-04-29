import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/diocese/app/bloc/diocese_event.dart';
import 'package:parish_aid_admin/features/diocese/app/bloc/diocese_state.dart';
import 'package:parish_aid_admin/features/diocese/domain/usecases/get_diocese.dart';

import '../../domain/usecases/show_diocese.dart';

class DioceseBloc extends Bloc<DioceseEvent, DioceseState> {
  final GetDiocese getDiocese;
  final ShowDiocese showDiocese;

  DioceseBloc({required this.getDiocese, required this.showDiocese})
      : super(DioceseInitial()) {
    on<DioceseEvent>(event, emit) async {
      if (event is GetDioceseEvent) {
        emit(GetDioceseLoading());

        final result = await getDiocese(NoParams());

        emit(result.fold((failure) => GetDioceseError(failure),
            (diocese) => GetDioceseLoaded(diocese)));
      } else if (event is ShowDioceseEvent) {
        emit(ShowDioceseLoading());

        final result =
            await showDiocese(ShowDioceseParams(dioceseId: event.dioceseId));

        emit(result.fold((failure) => ShowDioceseError(failure),
            (diocese) => ShowDioceseLoaded(diocese)));
      }
    }
  }
}

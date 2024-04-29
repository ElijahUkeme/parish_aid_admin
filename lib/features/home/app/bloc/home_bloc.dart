import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_parishes.dart';

import '../../domain/usecases/approve_parish.dart';
import '../../domain/usecases/create_parish.dart';
import '../../domain/usecases/delete_parish.dart';
import '../../domain/usecases/get_show.dart';
import '../../domain/usecases/update_parish.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetParishes getParishes;
  final GetShow getShow;
  final UpdateParish updateParish;
  final CreateParish createParish;
  final ApproveParish approveParish;
  final DeleteParish deleteParish;

  HomeBloc(
      {required this.getParishes,
      required this.getShow,
      required this.updateParish,
      required this.createParish,
      required this.approveParish,
      required this.deleteParish})
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetParishesEvent) {
        emit(GetParishesLoading());

        final result = await getParishes(NoParams());

        emit(result.fold((failure) => GetParishesError(failure),
            (parishes) => GetParishesLoaded(parishes)));
      } else if (event is GetShowEvent) {
        emit(GetShowLoading());

        final result = await getShow(GetShowParam(parish: event.parish));
        emit(result.fold((failure) => GetShowError(failure),
            (parish) => GetShowLoaded(parish)));
      } else if (event is UpdateParishEvent) {
        emit(UpdateParishLoading());

        final result = await updateParish(UpdateParishParams(
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
            coverImage: event.coverImage,
            parishId: event.parishId));
        emit(result.fold((failure) => UpdateParishError(failure),
            (parish) => UpdateParishLoaded(parish)));
      } else if (event is CreateParishEvent) {
        emit(CreateParishLoading());

        final result = await createParish(CreateParishParams(
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
        emit(result.fold((failure) => CreateParishError(failure),
            (parish) => CreateParishLoaded(parish)));
      } else if (event is ApproveParishEvent) {
        emit(ApproveParishLoading());

        final result =
            await approveParish(ApproveParishParam(parish: event.parish));
        emit(result.fold((failure) => ApproveParishError(failure),
            (parish) => ApproveParishLoaded(parish)));
      }
    });
  }
}

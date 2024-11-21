import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_parishes.dart';

import '../../domain/usecases/approve_parish.dart';
import '../../domain/usecases/create_parish.dart';
import '../../domain/usecases/create_verification_code.dart';
import '../../domain/usecases/delete_parish.dart';
import '../../domain/usecases/delete_verification_code.dart';
import '../../domain/usecases/get_parish.dart';
import '../../domain/usecases/get_verification_code_list.dart';
import '../../domain/usecases/get_verification_code_stat.dart';
import '../../domain/usecases/print_verification_code.dart';
import '../../domain/usecases/show_verification_code.dart';
import '../../domain/usecases/update_parish.dart';
import '../../domain/usecases/update_verification_code.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetParishes getParishes;
  final GetParish getParish;
  final UpdateParish updateParish;
  final CreateParish createParish;
  final ApproveParish approveParish;
  final DeleteParish deleteParish;
  final CreateVerificationCode createVerificationCode;
  final UpdateVerificationCode updateVerificationCode;
  final PrintVerificationCode printVerificationCode;
  final GetVerificationCodeList getVerificationCodeList;
  final GetVerificationCodeStat getVerificationCodeStat;
  final ShowVerificationCode showVerificationCode;
  final DeleteVerificationCode deleteVerificationCode;

  HomeBloc(
      {required this.getParishes,
      required this.getParish,
      required this.updateParish,
      required this.createParish,
      required this.approveParish,
      required this.deleteParish,
      required this.createVerificationCode,
      required this.updateVerificationCode,
      required this.printVerificationCode,
      required this.getVerificationCodeList,
      required this.getVerificationCodeStat,
      required this.showVerificationCode,
      required this.deleteVerificationCode})
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetParishesEvent) {
        emit(GetParishesLoading());

        final result = await getParishes(NoParams());

        emit(result.fold((failure) => GetParishesError(failure),
            (parishes) => GetParishesLoaded(parishes)));
      } else if (event is GetParishEvent) {
        emit(GetParishLoading());

        final result = await getParish(GetParishParam(parish: event.parish));
        emit(result.fold((failure) => GetParishError(failure),
            (parish) => GetParishLoaded(parish)));
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
      }else if(event is DeleteParishEvent){
        emit(DeleteParishLoading());

        final result = await deleteParish(DeleteParishParam(parish: event.parish));
        emit(result.fold((failure) => DeleteParishError(failure), (status) => DeleteParishLoaded(status)));
      }else if(event is CreateVerificationCodeEvent){
        emit(CreateVerificationCodeLoading());

        final result = await createVerificationCode(CreateVerificationCodeParams(parishId: event.parishId
            , quantity: event.quantity
            , expiresAt: event.expiresAt));

        emit(result.fold((failure)=>CreateVerificationCodeError(failure), (model)=>CreateVerificationCodeLoaded(model)));
      }else if(event is UpdateVerificationCodeEvent){
        emit(UpdateVerificationCodeLoading());

        final result = await updateVerificationCode(UpdateVerificationCodeParams(
            event.parishId, event.vCodeId,
            event.printStatus, event.status, event.expiresAt));

        emit(result.fold((failure)=>UpdateVerificationCodeError(failure),
            (model)=>UpdateVerificationCodeLoaded(model)));
      }else if(event is PrintVerificationCodeEvent){
        emit(PrintVerificationCodeLoading());

        final result = await printVerificationCode(PrintVerificationCodeParams(event.parishId, event.quantity));

        emit(result.fold((failure)=>PrintVerificationCodeError(failure), (model)=>PrintVerificationCodeLoaded(model)));
      }else if(event is GetVerificationCodeListEvent){
        emit(GetVerificationCodeListLoading());

        final result = await getVerificationCodeList(GetVerificationCodeListParam(event.parish));

        emit(result.fold((failure)=>GetVerificationCodeListError(failure),
            (model)=>GetVerificationCodeListLoaded(model)));
      }else if(event is GetVerificationCodeStatEvent){
        emit(GetVerificationCodeStatLoading());

        final result = await getVerificationCodeStat(GetVerificationCodeStatParam(event.parish));

        emit(result.fold((failure)=>GetVerificationCodeStatError(failure),
            (model)=>GetVerificationCodeStatLoaded(model)));
      }else if(event is ShowVerificationCodeEvent){
        emit(ShowVerificationCodeLoading());

        final result = await showVerificationCode(ShowVerificationCodeParam(event.parish, event.code));

        emit(result.fold((failure)=>ShowVerificationCodeError(failure),
            (data)=>ShowVerificationCodeLoaded(data)));
      }else if(event is DeleteVerificationCodeEvent){
        emit(DeleteVerificationCodeLoading());

        final result = await deleteVerificationCode(DeleteVerificationCodeParams(event.parish, event.code));

        emit(result.fold((failure)=>DeleteVerificationCodeError(failure),
            (status)=>DeleteVerificationCodeLoaded(status)));
      }
    });
  }
}

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_event.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_state.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/create_parishioner.dart';

import '../../domain/usecases/delete_parishioner.dart';
import '../../domain/usecases/get_parishioner.dart';
import '../../domain/usecases/get_parishioners.dart';
import '../../domain/usecases/update_parishioner.dart';

class ParishionerBloc extends Bloc<ParishionerEvent,ParishionerState>{
  final CreateParishioner createParishioner;
  final UpdateParishioner updateParishioner;
  final GetParishioners getParishioners;
  final GetParishioner getParishioner;
  final DeleteParishioner deleteParishioner;
  ParishionerBloc({required this.createParishioner,required this.updateParishioner,
    required this.getParishioners,required this.getParishioner,required this.deleteParishioner}): super(ParishionerInitial()){
    on<ParishionerEvent>((event,emit) async {
      if(event is CreateParishionerEvent){
        emit(CreateParishionerLoading());

        final result = await createParishioner(CreateParishionerParams(
          name: event.name,
            email:event.email,
            phoneNo:event.phoneNo,
            gender:event.gender,
            whatsAppNo:event.whatsAppNo,
            dob:event.dob,
            employmentStatus:event.employmentStatus,
            address:event.address,
            employerName:event.employerName,
            school:event.school,
            stateId:event.stateId,
            lgaId:event.lgaId,
            town:event.town,
            parishId:event.parishId,
            groupId:event.groupId,
            image:event.image
        ));
        emit(result.fold((failure) => CreateParishionerError(failure),
                (parishioner) => CreateParishionerLoaded(parishioner)));
      }else if(event is UpdateParishionerEvent){
        emit(UpdateParishionerLoading());

        final result = await updateParishioner(UpdateParishionerParams(
            name: event.name,
            email:event.email,
            phoneNo:event.phoneNo,
            gender:event.gender,
            whatsAppNo:event.whatsAppNo,
            dob:event.dob,
            employmentStatus:event.employmentStatus,
            address:event.address,
            employerName:event.employerName,
            school:event.school,
            stateId:event.stateId,
            lgaId:event.lgaId,
            town:event.town,
            parishId:event.parishId,
            groupId:event.groupId,
            image:event.image,
          parishioner: event.parishioner
        ));
        emit(result.fold((failure) => UpdateParishionerError(failure),
                (parish) => UpdateParishionerLoaded(parish)));
      }else if(event is GetParishionersEvent){
        emit(GetParishionersLoading());

        final result = await getParishioners(GetParishionersParam(event.parish));

        emit(result.fold((failure) => GetParishionersError(failure),
                (parishioners) => GetParishionersLoaded(parishioners)));
      }else if(event is GetParishionerEvent){
        emit(GetParishionerLoading());

        final result = await getParishioner(GetParishionerParams(event.parish, event.parishioner));
        emit(result.fold((failure) => GetParishionerError(failure), (parishioner) => GetParishionerLoaded(parishioner)));
      }else if(event is DeleteParishionerEvent){
        emit(DeleteParishionerLoading());

        final result = await deleteParishioner(DeleteParishionerParams(event.parish, event.parishioner));
        emit(result.fold((failure) => DeleteParishionerError(failure),
                (status) => DeleteParishionerLoaded(status)));
      }
    });
  }
}
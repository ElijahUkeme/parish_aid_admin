import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/events/app/home_event.dart';
import 'package:parish_aid_admin/states/app/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) {
      emit(HomeState());
    });
  }
}

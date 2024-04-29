import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/events/auth/login_events.dart';
import 'package:parish_aid_admin/states/auth/login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<FirstNameEvent>(_firstNameEvent);
    on<LastNameEvent>(_lastNameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<ValidateEvent>(_onValidateEvent);
    on<IconEvent>(_onIconEvent);
    on<LoadingBarEvent>(_onLoadingBarEvent);
    on<ActionEvent>(_onActionEvent);
  }

  void _firstNameEvent(FirstNameEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(firstName: event.firstName));
  }

  void _lastNameEvent(LastNameEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _emailEvent(EmailEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onValidateEvent(ValidateEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        showPassword: true, showEmail: true, showPreviewIcon: false));
  }

  void _onIconEvent(IconEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(showPreviewIcon: false));
  }

  void _onLoadingBarEvent(LoadingBarEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(showLoadingBar: event.isLoading));
  }

  void _onActionEvent(ActionEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isLoginState: event.isLogin));
  }
}

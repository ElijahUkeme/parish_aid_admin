import 'package:equatable/equatable.dart';

class UserAuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoginEvent extends UserAuthEvent {
  final String email;
  final String password;

  UserLoginEvent({required this.email, required this.password});
}

class UserFetchAccountEvent extends UserAuthEvent {}

class UserAccountPreviewEvent extends UserAuthEvent {
  final String email;
  UserAccountPreviewEvent({required this.email});
}

class UserForgotPasswordEvent extends UserAuthEvent {
  final String email;
  UserForgotPasswordEvent({required this.email});
}

class UserResetPasswordEvent extends UserAuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String code;

  UserResetPasswordEvent(
      {required this.email,
      required this.password,
      required this.confirmPassword,
      required this.code});
}

class UserAuthVerifyOtpEvent extends UserAuthEvent {
  final int code;
  final String email;
  final String type;

  UserAuthVerifyOtpEvent(
      {required this.code, required this.email, required this.type});
}

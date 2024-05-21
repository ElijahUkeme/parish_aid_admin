import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

//Verify Event
class VerifyEvent extends AuthEvent {
  final String email;
  VerifyEvent({required this.email});
}

//login Event
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

//SignUp Event
class SignUpEvent extends AuthEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  SignUpEvent(
      {required this.email,
      required this.password,
      required this.firstname,
      required this.lastname});
}

class ForgotPasswordEvent extends AuthEvent {
  final String identifier;
  ForgotPasswordEvent(this.identifier);
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String otp;

  ResetPasswordEvent(this.email, this.password, this.otp);
}

class VerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;
  final String type;

  VerifyOtpEvent(this.email, this.otp, this.type);
}

class RequestOtpEvent extends AuthEvent {
  final String email;
  RequestOtpEvent({required this.email});
}

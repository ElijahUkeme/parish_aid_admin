import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/auth/domain/entities/auth_user.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

//AuthInitial
class AuthInitial extends AuthState {}

//login state
class LoginLoaded extends AuthState {
  final bool status;
  LoginLoaded(this.status);
}

//loading state
class LoginLoading extends AuthState {}

//login Error state
class LoginError extends AuthState {
  final Failure failure;
  LoginError(this.failure);
}

//register states
class RegisterLoaded extends AuthState {
  final bool status;
  RegisterLoaded(this.status);
}

class RegisterLoading extends AuthState {}

class RegisterError extends AuthState {
  final Failure failure;
  RegisterError(this.failure);
}

class VerifyUserLoading extends AuthState {}

class VerifyUserError extends AuthState {
  final Failure failure;
  VerifyUserError(this.failure);
}

class VerifyUserLoaded extends AuthState {
  final AuthUser status;
  VerifyUserLoaded(this.status);
}

class LogoutLoading extends AuthState {}

class LogoutLoaded extends AuthState {
  final bool status;
  LogoutLoaded(this.status);
}

class LogoutError extends AuthState {
  final Failure failure;
  LogoutError(this.failure);
}

class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordLoaded extends AuthState {
  final bool status;
  ForgotPasswordLoaded(this.status);
}

class ForgotPasswordError extends AuthState {
  final Failure failure;
  ForgotPasswordError(this.failure);
}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordLoaded extends AuthState {
  final bool status;
  ResetPasswordLoaded(this.status);
}

class ResetPasswordError extends AuthState {
  final Failure failure;
  ResetPasswordError(this.failure);
}

class VerifyOtpLoading extends AuthState {}

class VerifyOtpLoaded extends AuthState {
  final bool status;
  VerifyOtpLoaded(this.status);
}

class VerifyOtpError extends AuthState {
  final Failure failure;
  VerifyOtpError(this.failure);
}

class RequestOtpLoading extends AuthState {}

class RequestOtpLoaded extends AuthState {
  final bool status;
  RequestOtpLoaded(this.status);
}

class RequestOtpError extends AuthState {
  final Failure failure;
  RequestOtpError(this.failure);
}

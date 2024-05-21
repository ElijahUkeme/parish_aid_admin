import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/auth/app/bloc/auth_event.dart';
import 'package:parish_aid_admin/features/auth/app/bloc/auth_state.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/login_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/sign_up_user.dart';
import 'package:parish_aid_admin/features/auth/domain/usecase/verify_user.dart';

import '../../domain/usecase/forgot_password.dart';
import '../../domain/usecase/logout_user.dart';
import '../../domain/usecase/request_otp.dart';
import '../../domain/usecase/reset_password.dart';
import '../../domain/usecase/verify_otp.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final VerifyUser verifyUser;
  final LoginUser loginUser;
  final SignUpUser signUpUser;
  final LogoutUser logoutUser;
  final ForgotPassword forgotPassword;
  final ResetPassword resetPassword;
  final VerifyOtp verifyOtp;
  final RequestOtp requestOtp;

  AuthBloc(
      {required this.verifyUser,
      required this.loginUser,
      required this.signUpUser,
      required this.logoutUser,
      required this.forgotPassword,
      required this.resetPassword,
      required this.verifyOtp,
      required this.requestOtp})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());

        final result = await loginUser(
            LoginUserParams(email: event.email, password: event.password));

        emit(result.fold(
            (failure) => LoginError(failure), (status) => LoginLoaded(status)));
      } else if (event is VerifyEvent) {
        emit(VerifyUserLoading());

        final result = await verifyUser(VerifyUserParams(email: event.email));
        emit(result.fold((failure) => VerifyUserError(failure),
            (status) => VerifyUserLoaded(status)));
      } else if (event is SignUpEvent) {
        emit(RegisterLoading());

        final result = await signUpUser(SignUpUserParams(
            firstname: event.firstname,
            lastname: event.lastname,
            email: event.email,
            password: event.password));

        emit(result.fold((failure) => RegisterError(failure),
            (status) => RegisterLoaded(status)));
      } else if (event is ForgotPasswordEvent) {
        emit(ForgotPasswordLoading());

        final result = await forgotPassword(
            ForgotPasswordParams(event.identifier.toString()));
        emit(result.fold((failure) => ForgotPasswordError(failure),
            (status) => ForgotPasswordLoaded(status)));
      } else if (event is ResetPasswordEvent) {
        emit(ResetPasswordLoading());

        final result = await resetPassword(ResetPasswordParams(
            oldPassword: event.password.toString(),
            newPassword: event.password.toString(),
            email: event.email.toString(),
            otp: event.otp));
        emit(result.fold((failure) => ResetPasswordError(failure),
            (status) => ResetPasswordLoaded(status)));
      } else if (event is VerifyOtpEvent) {
        emit(VerifyOtpLoading());

        final result = await verifyOtp(VerifyOtpParams(
            email: event.email, otp: event.otp, type: event.type));

        emit(result.fold((failure) => VerifyOtpError(failure),
            (status) => VerifyOtpLoaded(status)));
      } else if (event is RequestOtpEvent) {
        emit(RequestOtpLoading());

        final result = await requestOtp(RequestOtpParams(email: event.email));

        emit(result.fold((failure) => RequestOtpError(failure),
            (status) => RequestOtpLoaded(status)));
      }
    });
  }
}

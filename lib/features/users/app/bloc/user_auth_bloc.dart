import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_event.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_state.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_auth_forgot_password.dart';
import 'package:parish_aid_admin/features/users/domain/usecases/user_login.dart';

import '../../../auth/domain/usecase/request_otp.dart';
import '../../domain/usecases/fetch_account.dart';
import '../../domain/usecases/user_account_preview.dart';
import '../../domain/usecases/user_auth_logout.dart';
import '../../domain/usecases/user_auth_reset_password.dart';
import '../../domain/usecases/user_auth_verify_otp.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final UserLogin userLogin;
  final FetchAccount fetchAccount;
  final UserAccountPreview userAccountPreview;
  final UserAuthLogout userAuthLogout;
  final UserAuthForgotPassword userAuthForgotPassword;
  final UserAuthResetPassword userAuthResetPassword;
  final UserAuthVerifyOtp userAuthVerifyOtp;

  UserAuthBloc(
      {required this.userLogin,
      required this.fetchAccount,
      required this.userAccountPreview,
      required this.userAuthLogout,
      required this.userAuthForgotPassword,
      required this.userAuthResetPassword,
      required this.userAuthVerifyOtp})
      : super(UserAuthInitial()) {
    on<UserAuthEvent>((event, emit) async {
      if (event is UserLoginEvent) {
        emit(UserLoginLoading());

        final result = await userLogin(
            UserLoginParams(email: event.email, password: event.password));

        emit(result.fold((failure) => UserLoginError(failure),
            (model) => UserLoginLoaded(model)));
      } else if (event is UserFetchAccountEvent) {
        emit(UserFetchAccountLoading());

        final result = await fetchAccount(NoParams());
        emit(result.fold((failure) => UserFetchAccountError(failure),
            (account) => UserFetchAccountLoaded(account)));
      } else if (event is UserAccountPreviewEvent) {
        emit(UserAccountPreviewLoading());

        final result = await userAccountPreview(
            UserAccountPreviewParams(email: event.email));

        emit(result.fold((failure) => UserAccountPreviewError(failure),
            (previewAccount) => UserAccountPreviewLoaded(previewAccount)));
      } else if (event is UserForgotPasswordEvent) {
        emit(UserForgotPasswordLoading());

        final result = await userAuthForgotPassword(
            UserAuthForgotPasswordParams(email: event.email));

        emit(result.fold((failure) => UserForgotPasswordError(failure),
            (status) => UserForgotPasswordLoaded(status)));
      } else if (event is UserResetPasswordEvent) {
        emit(UserResetPasswordLoading());

        final result = await userAuthResetPassword(UserAuthResetPasswordParams(
            email: event.email,
            password: event.password,
            code: event.code,
            passwordConfirmation: event.confirmPassword));

        emit(result.fold((failure) => UserResetPasswordError(failure),
            (data) => UserResetPasswordLoaded(data)));
      } else if (event is UserAuthVerifyOtpEvent) {
        emit(UserAuthVerifyOtpLoading());

        final result = await userAuthVerifyOtp(UserAuthVerifyOtpParams(
            email: event.email, otp: event.code, type: event.type));

        emit(result.fold((failure) => UserAuthVerifyOtpError(failure),
            (status) => UserAuthVerifyOtpLoaded(status)));
      }
    });
  }
}

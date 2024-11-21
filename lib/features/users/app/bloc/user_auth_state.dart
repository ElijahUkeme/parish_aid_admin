import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_preview_model.dart';

import '../../../../core/failures/failure.dart';
import '../../data/models/user_auth_reset_password_model.dart';

class UserAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserAuthInitial extends UserAuthState {}

class UserLoginLoaded extends UserAuthState {
  final AuthUserModel model;
  UserLoginLoaded(this.model);
}

//loading state
class UserLoginLoading extends UserAuthState {}

//login Error state
class UserLoginError extends UserAuthState {
  final Failure failure;
  UserLoginError(this.failure);
}

class UserFetchAccountLoading extends UserAuthState {}

class UserFetchAccountLoaded extends UserAuthState {
  final UserAccountFetchModel userAccountFetchModel;
  UserFetchAccountLoaded(this.userAccountFetchModel);
}

class UserFetchAccountError extends UserAuthState {
  final Failure failure;
  UserFetchAccountError(this.failure);
}

class UserAccountPreviewLoading extends UserAuthState {}

class UserAccountPreviewLoaded extends UserAuthState {
  final UserAccountPreviewModel userAccountPreviewModel;
  UserAccountPreviewLoaded(this.userAccountPreviewModel);
}

class UserAccountPreviewError extends UserAuthState {
  final Failure failure;
  UserAccountPreviewError(this.failure);
}

class UserAuthLogoutLoading extends UserAuthState {}

class UserAuthLogoutLoaded extends UserAuthState {
  final bool status;
  UserAuthLogoutLoaded(this.status);
}

class UserAuthLogoutError extends UserAuthState {
  final Failure failure;
  UserAuthLogoutError(this.failure);
}

class UserForgotPasswordLoading extends UserAuthState {}

class UserForgotPasswordLoaded extends UserAuthState {
  final UserAuthResetPasswordModel userAuthResetPasswordModel;

  UserForgotPasswordLoaded(this.userAuthResetPasswordModel);
}

class UserForgotPasswordError extends UserAuthState {
  final Failure failure;
  UserForgotPasswordError(this.failure);
}

class UserResetPasswordLoading extends UserAuthState {}

class UserResetPasswordLoaded extends UserAuthState {
  final UserAuthResetPasswordModel userAuthResetPasswordModel;
  UserResetPasswordLoaded(this.userAuthResetPasswordModel);
}

class UserResetPasswordError extends UserAuthState {
  final Failure failure;

  UserResetPasswordError(this.failure);
}

class UserAuthVerifyOtpLoading extends UserAuthState {}

class UserAuthVerifyOtpLoaded extends UserAuthState {
  final bool status;

  UserAuthVerifyOtpLoaded(this.status);
}

class UserAuthVerifyOtpError extends UserAuthState {
  final Failure failure;

  UserAuthVerifyOtpError(this.failure);
}

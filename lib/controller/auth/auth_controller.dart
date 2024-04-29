import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/blocs/auth/login_bloc.dart';
import 'package:parish_aid_admin/events/auth/login_events.dart';
import 'package:parish_aid_admin/model/auth/auth_model.dart';
import 'package:parish_aid_admin/model/auth/login_model.dart';
import 'package:parish_aid_admin/model/auth/sign_up_model.dart';
import 'package:parish_aid_admin/repository/auth/auth_repository.dart';
import 'package:parish_aid_admin/routes/name.dart';
import 'package:parish_aid_admin/widgets/auth/auth_widgets.dart';

class AuthController {
  final BuildContext context;
  AuthController({required this.context});

  Future<void> handleRegistration() async {
    if (context.mounted) {
      final state = context.read<LoginBloc>().state;
      String firstName = state.firstName;
      String lastname = state.lastName;
      String email = state.email;
      String password = state.password;

      if (firstName.isEmpty) {
        toastInfo(msg: "Please Enter your First Name");
        return;
      }
      if (lastname.isEmpty) {
        toastInfo(msg: "Please Enter your Last Name");
        return;
      }
      if (email.isEmpty) {
        toastInfo(msg: "Please Enter your Email Address");
        return;
      }
      if (password.isEmpty) {
        toastInfo(msg: "Please Enter your Password");
        return;
      }
      try {
        context.read<LoginBloc>().add(LoadingBarEvent(true));
        SignUpModel signUpModel = SignUpModel();
        signUpModel.firstName = firstName;
        signUpModel.lastName = lastname;
        signUpModel.email = email;
        signUpModel.password = password;
        AuthRepository.signUp(signUpModel).then((value) => {
              if (value.response!.code == 200)
                {
                  context.read<LoginBloc>().add(LoadingBarEvent(false)),
                  if (context.mounted)
                    {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.HOME, (route) => false)
                    }
                }
              else
                {
                  context.read<LoginBloc>().add(LoadingBarEvent(false)),
                }
            });
      } catch (e) {
        context.read<LoginBloc>().add(LoadingBarEvent(false));
      }
    }
  }

  Future<void> handlePreview() async {
    final state = context.read<LoginBloc>().state;
    String email = state.email;
    try {
      context.read<LoginBloc>().add(LoadingBarEvent(true));
      AuthModel authModel = AuthModel();
      authModel.email = email;
      AuthRepository.preview(authModel).then((value) => {
            if (value.response!.code == 200)
              {
                //meaning that user exist
                //then show the password field for the user to sign in
                context.read<LoginBloc>().add(ActionEvent(true)),
                context.read<LoginBloc>().add(LoadingBarEvent(false)),
                context.read<LoginBloc>().add(ValidateEvent()),
                context.read<LoginBloc>().add(IconEvent())
              }
            else
              {
                //meaning that user does not exist
                //show sign up fields for user sign up
                context.read<LoginBloc>().add(ActionEvent(false)),
                context.read<LoginBloc>().add(LoadingBarEvent(false)),
                context.read<LoginBloc>().add(ValidateEvent()),
                context.read<LoginBloc>().add(IconEvent()),
              }
          });
    } catch (e) {
      context.read<LoginBloc>().add(LoadingBarEvent(false));
      toastInfo(msg: e.toString());
    }
  }

  Future<void> handleLogin() async {
    final state = context.read<LoginBloc>().state;
    String email = state.email;
    String password = state.password;

    if (email.isEmpty) {
      toastInfo(msg: "Email Address Required");
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: "Password Required");
      return;
    }
    try {
      context.read<LoginBloc>().add(LoadingBarEvent(true));
      LoginModel loginModel = LoginModel();
      loginModel.email = email;
      loginModel.password = password;
      AuthRepository.login(loginModel).then((value) => {
            if (value.response!.code == 200)
              {
                context.read<LoginBloc>().add(LoadingBarEvent(false)),
                toastInfo(msg: value.response!.message!),
                if (context.mounted)
                  {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.HOME, (route) => false)
                  }
              }
            else
              {
                context.read<LoginBloc>().add(LoadingBarEvent(false)),
                toastInfo(msg: value.response!.message!)
              }
          });
    } catch (e) {
      context.read<LoginBloc>().add(LoadingBarEvent(false));
      toastInfo(msg: e.toString());
    }
  }
}

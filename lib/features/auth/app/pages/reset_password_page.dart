import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/auth/app/bloc/auth_event.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_event.dart';

import '../../../../core/utils/urls.dart';
import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../routes/name.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../users/app/bloc/user_auth_bloc.dart';
import '../../../users/app/bloc/user_auth_state.dart';
import '../widgets/auth_page_widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  bool loading = false;
  String email = "";
  String password = "";
  String confirmPassword = "";
  String otp = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<UserAuthBloc, UserAuthState>(builder: (context, state) {
      if (state is UserResetPasswordLoading) {
        loading = true;
      } else if (state is UserResetPasswordLoaded) {
        loading = false;
        Future.delayed(Duration.zero, () {
          if (mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.ONBOARDING_AUTH, (route) => false);
          }
        });
      } else if (state is UserResetPasswordError) {
        loading = false;
        Future.delayed(const Duration(seconds: 1)).then((value) => {
          if (context.mounted)
            {
              showCustomTopSnackBar(context,
                  message: state.failure.message, color: Colors.red)
            }
        });
      }

      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue.shade900.withOpacity(0.9),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SizedBox(
              height: size.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Urls.defaultBackgroundImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue.shade900.withOpacity(0.6),
                  ),
                  const SizedBox(height: 65),
                  //card and footer ui
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          alignment: Alignment.center,
                          width: size.width * 0.9,
                          height: size.height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                //logo & text
                                logo(size.height / 10, size.height / 6),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                richText("Password Reset", 20),
                                const SizedBox(height: 20),
                                buildInputFields(size, false, "Email",
                                    "Enter your Email", false, (value) {
                                      email = value;
                                    }),

                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                buildInputFields(size, false, "Password",
                                    "Enter your new password", true, (value) {
                                      password = value;
                                    }),

                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                buildInputFields(size, false, "Confirm password",
                                    "Enter your Confirm password", true, (value) {
                                      confirmPassword = value;
                                    }),

                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                buildInputFields(size, false, "Otp",
                                    "Enter the sent otp", false, (value) {
                                      otp = value;
                                    }),

                                SizedBox(
                                  height: size.height * 0.05,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    submitResetPassword();
                                  },
                                  child: Stack(
                                    children: [
                                      triggerActionButtonBlue(size, "Submit"),
                                      Positioned(
                                        bottom: 15,
                                        left: 100,
                                        child: Visibility(
                                          visible: loading,
                                          child: buildLoadingIndicator(
                                              color:
                                              Colors.grey.withOpacity(0.8)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                              ],
                            ),
                          ),
                        ),
                        //buildFooter(size),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void submitResetPassword(){
    if(email.isEmpty){
      showCustomTopSnackBar(context, message: "Email address required");
    }else if(password.isEmpty){
      showCustomTopSnackBar(context, message: "Password required");
    }else if(confirmPassword.isEmpty){
      showCustomTopSnackBar(context, message: "Confirm password required");
    }else if(confirmPassword != password){
      showCustomTopSnackBar(context, message: "Confirm password and Password are not the same");
    }else if(otp.isEmpty){
      showCustomTopSnackBar(context, message: "Otp required");
    }else{
      BlocProvider.of<UserAuthBloc>(context).add(UserResetPasswordEvent(
          email: email, password: password,
          confirmPassword: confirmPassword, code: otp));
    }
  }
}

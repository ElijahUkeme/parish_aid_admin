import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_event.dart';

import '../../../../core/utils/urls.dart';
import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../routes/name.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../users/app/bloc/user_auth_bloc.dart';
import '../../../users/app/bloc/user_auth_state.dart';
import '../widgets/auth_page_widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<UserAuthBloc, UserAuthState>(builder: (context, state) {
      if (state is UserForgotPasswordLoading) {
        loading = true;
      } else if (state is UserForgotPasswordLoaded) {
        loading = false;
        Future.delayed(Duration.zero, () {
          if (mounted) {
            showCustomTopSnackBar(context, message: state.userAuthResetPasswordModel.response!.message!);
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.RESET_PASSWORD, (route) => false);
          }
        });
      } else if (state is UserForgotPasswordError) {
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
                          height: size.height * 0.5,
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
                                richText("Forgot Password", 18),
                                const SizedBox(height: 20),
                                buildInputFields(size, false, "Email",
                                    "Enter your Email", false, (value) {
                                  email = value;
                                }),

                                SizedBox(
                                  height: size.height * 0.05,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    requestForPasswordReset();
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

  void requestForPasswordReset(){
    if(email.isEmpty){
      showCustomTopSnackBar(context, message: "Email address required");
    }else{
      BlocProvider.of<UserAuthBloc>(context).add(UserForgotPasswordEvent(email: email));
    }
  }
}

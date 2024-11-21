import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/utils/urls.dart';
import 'package:parish_aid_admin/features/auth/app/bloc/auth_bloc.dart';
import 'package:parish_aid_admin/features/auth/app/bloc/auth_state.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../routes/name.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../bloc/auth_event.dart';
import '../widgets/auth_page_widgets.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    action = AuthAction.VERIFY;
  }

  AuthAction action = AuthAction.LOGIN;

  //Error text
  String errorText = "";

  //Success message
  String msg = "";

  //Registration Data
  String email = "";
  String firstname = "";
  String lastname = "";
  String password = "";

  //SignIn states
  bool signingIn = false;
  bool signingInError = false;
  bool previewUser = true;

  //SignUp States
  bool signingUp = false;
  bool signUpError = false;

  //check User
  bool checkInUser = false;
  bool checkError = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is LoginLoading) {
        action = AuthAction.LOGIN;
        signingIn = true;
        signingInError = false;
        errorText = "";
      } else if (state is LoginLoaded) {
        action = AuthAction.LOGIN;
        signingIn = false;
        signingInError = false;
        errorText = "";
        Future.delayed(Duration.zero, () {
          if (mounted) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoutes.ONBOARDING_AUTH, (route) => false);
          }
        });
      } else if (state is LoginError) {
        action = AuthAction.LOGIN;
        signingIn = false;
        signingInError = true;
        errorText = "";
        Future.delayed(const Duration(seconds: 1)).then((value) => {
              if (context.mounted)
                {
                  showCustomTopSnackBar(context,
                      message: state.failure.message, color: Colors.red)
                }
            });
      } else if (state is RegisterError) {
        action = AuthAction.SIGNUP;
        signingUp = false;
        signingInError = true;
        errorText = state.failure.message;
        Future.delayed(const Duration(seconds: 2)).then((value) => {
              if (context.mounted)
                {
                  showCustomTopSnackBar(context,
                      message: "Registration Failed, Try Again")
                }
            });
      } else if (state is RegisterLoading) {
        action = AuthAction.SIGNUP;
        signingUp = true;
        signUpError = false;
        errorText = "";
      } else if (state is RegisterLoaded) {
        action = AuthAction.SIGNUP;
        signUpError = false;
        errorText = "";
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
        showCustomTopSnackBar(context, message: "Registration was Successful");
      } else if (state is VerifyUserLoading) {
        action = AuthAction.VERIFY;
        checkInUser = true;
        checkError = false;
        errorText = "";
      } else if (state is VerifyUserLoaded) {
        action = AuthAction.VERIFY;
        checkInUser = false;
        checkError = false;
        errorText = "";
        var user = state.status;
        if (user.response!.code != null) {
          print("The auth page returns ${user.response!.code}");
          if (user.response!.code == 200) {
            print("Login called");
            action = AuthAction.LOGIN;
          } else {
            print("Signup called");
            action = AuthAction.SIGNUP;
          }
        }
      } else if (state is VerifyUserError) {
        action = AuthAction.VERIFY;
        checkError = false;
        checkInUser = false;
        errorText = "";

        Future.delayed(const Duration(seconds: 1)).then((value) => {
              if (context.mounted)
                {
                  if (!(state.failure.message == "Invalid data"))
                    {
                      showCustomTopSnackBar(context,
                          message: state.failure.message, color: Colors.red)
                    }
                }
            });
      }
      return SafeArea(
        child: Scaffold(
          //backgroundColor: Colors.blue.shade900,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.blue.shade900.withOpacity(0.9),
            elevation: 0.0,
            toolbarHeight: 0,
          ),
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
                          height: action == AuthAction.VERIFY
                              ? 270
                              : action == AuthAction.SIGNUP
                                  ? 450
                                  : size.height * 0.7,
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
                                  height: size.height * 0.02,
                                ),
                                Visibility(
                                    visible: action == AuthAction.LOGIN ||
                                        action == AuthAction.SIGNUP,
                                    child: richText(
                                        action == AuthAction.LOGIN
                                            ? "Login"
                                            : "SignUp",
                                        24)),

                                //email & password textField
                                Stack(
                                  children: [
                                    Positioned(
                                      top: 30,
                                      left: 150,
                                      child: Center(
                                        child: Visibility(
                                            visible: checkInUser,
                                            child: buildLoadingIndicator()),
                                      ),
                                    ),
                                    Visibility(
                                      visible: action == AuthAction.VERIFY ||
                                          action == AuthAction.LOGIN || action==AuthAction.SIGNUP,
                                      child: buildInputFields(
                                          size,
                                          false,
                                          "Email",
                                          "Enter your Email",
                                          false, (value) {
                                        email = value;
                                        if (action == AuthAction.VERIFY) {
                                          if (value.endsWith(".com")) {
                                            Future.delayed(
                                                    const Duration(seconds: 1))
                                                .then((value) {
                                              performVerification();
                                            });
                                          }
                                        }
                                      }),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Visibility(
                                  visible: action == AuthAction.LOGIN || action == AuthAction.SIGNUP,
                                  child: buildInputFields(size, false, "Password",
                                      "Enter your Password", true, (value) {
                                    password = value;
                                  }),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Visibility(
                                  visible: action == AuthAction.SIGNUP,
                                  child: buildInputFields(
                                      size,
                                      false,
                                      "FirstName",
                                      "Enter your FirstName",
                                      false, (value) {
                                    firstname = value;
                                  }),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),

                                Visibility(
                                  visible: action == AuthAction.SIGNUP,
                                  child: buildInputFields(size, false, "LastName",
                                      "Enter your LastName", false, (value) {
                                    lastname = value;
                                  }),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),

                                //remember & forget text
                                Visibility(
                                    visible: action == AuthAction.LOGIN,
                                    child: buildRememberForgetSection(()=>forgotPassword())),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                //sign in button
                                Visibility(
                                  visible: action == AuthAction.LOGIN ||
                                      action == AuthAction.SIGNUP,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (action == AuthAction.LOGIN) {
                                        performLogin();
                                      } else {
                                        performRegistration();
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        triggerActionButtonBlue(
                                            size,
                                            action == AuthAction.LOGIN
                                                ? "Login"
                                                : "Register"),
                                        Positioned(
                                          bottom: 15,
                                          left: 100,
                                          child: Visibility(
                                            visible: signingIn,
                                            child: buildLoadingIndicator(
                                                color:
                                                    Colors.grey.withOpacity(0.8)),
                                          ),
                                        ),
                                      ],
                                    ),
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

  void performRegistration() {
    if (firstname.isEmpty) {
      toastInfo(msg: "First name required");
    } else if (lastname.isEmpty) {
      toastInfo(msg: "Last name required");
    } else if (email.isEmpty) {
      toastInfo(msg: "Email required");
    } else if (password.isEmpty) {
      toastInfo(msg: "Password required");
    } else {
      BlocProvider.of<AuthBloc>(context).add(SignUpEvent(
          email: email,
          password: password,
          firstname: firstname,
          lastname: lastname));
    }
  }

  void forgotPassword(){
    print("Forgot password clicked");
  }

  void performLogin() {
    if (email.isEmpty) {
      toastInfo(msg: "Email required");
    } else if (password.isEmpty) {
      toastInfo(msg: "Password required");
    } else {
      BlocProvider.of<AuthBloc>(context)
          .add(LoginEvent(email: email, password: password));
    }
  }

  void performVerification() {
    BlocProvider.of<AuthBloc>(context).add(VerifyEvent(email: email));
  }
}

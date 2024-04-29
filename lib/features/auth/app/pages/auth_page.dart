import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/auth/app/bloc/auth_state.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/auth/domain/entities/auth_user.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/screens/home/home_screen.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../injection_container.dart';
import '../../../../routes/name.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    action = AuthAction.VERIFY;
    super.initState();
  }

  AuthAction action = AuthAction.LOGIN;
  final authBloc = sl<AuthBloc>();
  final homeBloc = sl<HomeBloc>();

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

  //SignUp States
  bool signingUp = false;
  bool signUpError = false;

  //check User
  bool checkInUser = false;
  bool checkError = false;

  @override
  Widget build(BuildContext context) {
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
                .pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
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
      return BlocBuilder(builder: (context, state) {
        return Scaffold(
            backgroundColor: Color(0xFFF1F3F6),
            body: SafeArea(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  //horizontal: ScreenUtil().setWidth(120)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Visibility(
                          visible: action == AuthAction.LOGIN ||
                              action == AuthAction.SIGNUP,
                          child: Text(
                            action == AuthAction.LOGIN ? "Login" : "Sign Up",
                            style: const TextStyle(
                                color: Color(0xFF4D70A6),
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: action == AuthAction.SIGNUP,
                        child: Stack(
                          children: <Widget>[
                            buildTextField("First Name", "", (value) {
                              firstname = value;
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: action == AuthAction.SIGNUP,
                        child: Stack(
                          children: <Widget>[
                            buildTextField("Last Name", "", (value) {
                              lastname = value;
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Stack(
                        children: <Widget>[
                          Center(
                            child: Visibility(
                                visible: signingIn || signingUp || checkInUser,
                                child: buildLoadingIndicator()),
                          ),
                          buildTextField("Email", "", (value) {
                            email = value;
                            if (action == AuthAction.VERIFY) {
                              if (value.endsWith(".com")) {
                                Future.delayed(const Duration(seconds: 1))
                                    .then((value) {
                                  performVerification();
                                });
                              }
                            }
                          })
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: false,
                        child: GestureDetector(
                          onTap: () async {
                            //AuthController(context: context).handlePreview();
                          },
                          child: Container(
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.verified,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: action == AuthAction.LOGIN ||
                            action == AuthAction.SIGNUP,
                        child: buildTextField("Password", "password", (value) {
                          password = value;
                        }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Visibility(
                        visible: action == AuthAction.LOGIN ||
                            action == AuthAction.SIGNUP,
                        child: GestureDetector(
                          onTap: () {
                            // if (action == AuthAction.LOGIN) {
                            //   performLogin();
                            // } else {
                            //   performRegistration();
                            // }
                            testData();
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            height: 50,
                            margin: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: Color(0xFFF1F3F6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(10, 10),
                                      color: Color(0xFF4D70A6).withOpacity(0.2),
                                      blurRadius: 16),
                                  const BoxShadow(
                                      offset: Offset(-10, -10),
                                      color: Color.fromARGB(170, 255, 255, 255),
                                      blurRadius: 10),
                                ]),
                            child: Text(
                              action == AuthAction.LOGIN ? "Login" : "Sign Up",
                              style: const TextStyle(
                                  color: Color(0xFF4D70A6), fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ));
      });
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

  void testData() {
    BlocProvider.of<HomeBloc>(context).add(HomeEvent());
  }
}

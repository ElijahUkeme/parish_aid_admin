import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/auth/app/bloc/auth_state.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';
import 'package:parish_aid_admin/features/auth/domain/entities/auth_user.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_event.dart';
import 'package:parish_aid_admin/screens/home/home_screen.dart';

import '../../../../core/utils/color.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../injection_container.dart';
import '../../../../routes/name.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPage();
}

class _TestingPage extends State<TestingPage> {
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
  bool previewUser = true;

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
      return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colorz.iphone12Purple.withOpacity(0.5),
              elevation: 0,
            ),
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
                            style: TextStyle(
                                color: Colorz.iphone12Purple.withOpacity(0.5),
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
                                visible: checkInUser,
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
                            if (action == AuthAction.LOGIN) {
                              performLogin();
                            } else {
                              performRegistration();
                            }
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
                                        color: Colorz.iphone12Purple
                                            .withOpacity(0.5),
                                        blurRadius: 16),
                                    const BoxShadow(
                                        offset: Offset(-10, -10),
                                        color:
                                            Color.fromARGB(170, 255, 255, 255),
                                        blurRadius: 10),
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                      visible: signingIn || signingUp,
                                      child: buildLoadingIndicator()),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    action == AuthAction.LOGIN
                                        ? "Login"
                                        : "Sign Up",
                                    style: TextStyle(
                                        color: Colorz.iphone12Purple
                                            .withOpacity(0.5),
                                        fontSize: 16),
                                  ),
                                ],
                              )),
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

  void forgotPassword() {
    BlocProvider.of<AuthBloc>(context).add(ForgotPasswordEvent(email));
  }

  void resetPassword() {
    BlocProvider.of<AuthBloc>(context)
        .add(ResetPasswordEvent("sudo@parishaid.com", "password", "3244"));
  }

  void verifyOtp() {
    BlocProvider.of<AuthBloc>(context)
        .add(VerifyOtpEvent("sudo@parishaid.com", "2998", "verify_email"));
  }

  void requestOtp() {
    BlocProvider.of<AuthBloc>(context).add(RequestOtpEvent(email: email));
  }

  void getParishes() {
    BlocProvider.of<HomeBloc>(context).add(GetParishesEvent());
  }

  void getShow() {
    BlocProvider.of<HomeBloc>(context).add(GetShowEvent(parish: 5));
  }

  void updateParish() {
    BlocProvider.of<HomeBloc>(context).add(UpdateParishEvent(
        name: "Test Parish",
        acronym: "CKC",
        email: "testparish@email.com",
        phoneNo: "+2348144901220",
        address: "This is a test address",
        dioceseId: 1,
        stateId: 2674,
        lgaId: 1,
        town: "Isoko North",
        parishPriestName: "Test priest",
        password: "password",
        registrarEmail: "testparish@email.com",
        parishId: 30));
  }
}

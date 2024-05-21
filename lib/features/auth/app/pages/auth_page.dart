import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parish_aid_admin/features/auth/app/bloc/auth_bloc.dart';
import 'package:parish_aid_admin/features/auth/app/bloc/auth_state.dart';
import 'package:parish_aid_admin/features/onboarding/app/pages/create_parish_page.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_bloc.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_event.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_state.dart';
import 'package:parish_aid_admin/features/users/app/widgets/drop_down_menu_widget.dart';

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
  String _selectedAction = "Sign Up as";

  final List<String> _selectedActionList = [
    "Sign Up as",
    "Parish",
    "Group",
  ];

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
    return BlocBuilder<UserAuthBloc, UserAuthState>(builder: (context, state) {
      if (state is UserLoginLoading) {
        action = AuthAction.LOGIN;
        signingIn = true;
        signingInError = false;
        errorText = "";
      } else if (state is UserLoginLoaded) {
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
      } else if (state is UserLoginError) {
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
        // } else if (state is RegisterError) {
        //   action = AuthAction.SIGNUP;
        //   signingUp = false;
        //   signingInError = true;
        //   errorText = state.failure.message;
        //   Future.delayed(const Duration(seconds: 2)).then((value) => {
        //         if (context.mounted)
        //           {
        //             showCustomTopSnackBar(context,
        //                 message: "Registration Failed, Try Again")
        //           }
        //       });
        // } else if (state is RegisterLoading) {
        //   action = AuthAction.SIGNUP;
        //   signingUp = true;
        //   signUpError = false;
        //   errorText = "";
        // } else if (state is RegisterLoaded) {
        //   action = AuthAction.SIGNUP;
        //   signUpError = false;
        //   errorText = "";
        //   Navigator.of(context)
        //       .pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
        //   showCustomTopSnackBar(context, message: "Registration was Successful");
      } else if (state is UserAccountPreviewLoading) {
        action = AuthAction.VERIFY;
        checkInUser = true;
        checkError = false;
        errorText = "";
      } else if (state is UserAccountPreviewLoaded) {
        action = AuthAction.VERIFY;
        checkInUser = false;
        checkError = false;
        errorText = "";
        var user = state.userAccountPreviewModel;
        if (user.response!.code != null) {
          print("The auth page returns ${user.response!.code}");
          if (user.response!.code == 200) {
            print("Login called");
            action = AuthAction.LOGIN;
          } else {
            print("Signup called");
            action = AuthAction.SIGNUP;
            signingUp = true;
          }
        }
      } else if (state is UserAccountPreviewError) {
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

      return Scaffold(
        backgroundColor: Colors.blue.shade900,
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
                      image: AssetImage("assets/images/catholic.webp"),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                                      action == AuthAction.LOGIN ? "Login" : "",
                                      24)),
                              // SizedBox(
                              //   height: size.height * 0.05,
                              // ),

                              //Drop down menu for user's selection
                              Visibility(
                                  visible: signingUp,
                                  child: buildDropDownButton2()),

                              //email & password textField
                              Stack(
                                children: [
                                  Positioned(
                                    top: 30,
                                    left: 130,
                                    child: Center(
                                      child: Visibility(
                                          visible: checkInUser,
                                          child: buildLoadingIndicator()),
                                    ),
                                  ),
                                  Visibility(
                                    visible: action == AuthAction.VERIFY ||
                                        action == AuthAction.LOGIN,
                                    child: buildInputFields(size, "Email",
                                        "Enter your Email", false, (value) {
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
                                visible: action == AuthAction.LOGIN,
                                child: buildInputFields(size, "Password",
                                    "Enter your Password", true, (value) {
                                  password = value;
                                }),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              // Visibility(
                              //   visible: action == AuthAction.SIGNUP,
                              //   child: buildInputFields(size, "FirstName",
                              //       "Enter your FirstName", false, (value) {
                              //     firstname = value;
                              //   }),
                              // ),
                              // SizedBox(
                              //   height: size.height * 0.03,
                              // ),
                              //
                              // Visibility(
                              //   visible: action == AuthAction.SIGNUP,
                              //   child: buildInputFields(size, "LastName",
                              //       "Enter your LastName", false, (value) {
                              //     lastname = value;
                              //   }),
                              // ),
                              // SizedBox(
                              //   height: size.height * 0.03,
                              // ),

                              //remember & forget text
                              Visibility(
                                  visible: action == AuthAction.LOGIN,
                                  child: buildRememberForgetSection()),
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
                                      performRegistration(_selectedAction);
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      triggerActionButtonBlue(
                                          size,
                                          action == AuthAction.LOGIN
                                              ? "Login"
                                              : "Proceed"),
                                      Positioned(
                                        bottom: 20,
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
      );
    });
  }

  void performRegistration(String action) {
    if (action == "Parish") {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CreateParishPage()));
    } else if (action == "Group") {
      toastInfo(msg: "Want to create a Group");
    } else if (action == "Diocese") {
      toastInfo(msg: "Want to create a Diocese");
    }
  }

  void performLogin() {
    if (email.isEmpty) {
      toastInfo(msg: "Email required");
    } else if (password.isEmpty) {
      toastInfo(msg: "Password required");
    } else {
      BlocProvider.of<UserAuthBloc>(context)
          .add(UserLoginEvent(email: email, password: password));
    }
  }

  void performVerification() {
    BlocProvider.of<UserAuthBloc>(context)
        .add(UserAccountPreviewEvent(email: email));
  }

  Widget dropDownMenu() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3))
          ]),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 360,
            //margin: EdgeInsets.only(right: 14),
            child: DropdownButton2(
              value: _selectedAction,

              // Down Arrow Ico

              // Array list of items
              items: _selectedActionList.map((String items) {
                return DropdownMenuItem(
                  alignment: AlignmentDirectional.center,
                  value: items,
                  child: Container(
                    margin: EdgeInsets.only(right: 170, left: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 3))
                        ]),
                    child: Text(
                      items,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900),
                    ),
                  ),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAction = newValue!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropDownButton2() {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3))
          ]),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          iconStyleData: IconStyleData(iconSize: 30),
          items: _selectedActionList
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
              .toList(),
          value: _selectedAction,
          onChanged: (String? value) {
            setState(() {
              _selectedAction = value!;
            });
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            width: 140,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            isOverButton: true,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 3))
                ]),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
  }
}

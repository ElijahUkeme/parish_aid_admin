import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:parish_aid_admin/core/json_checker/json_checker.dart';
import 'package:parish_aid_admin/core/network_info/network_info.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/core/utils/urls.dart';
import 'package:parish_aid_admin/features/auth/data/sources/auth_remote_source.dart';
import 'package:parish_aid_admin/repository/auth/auth_repository.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../injection_container.dart';
import '../../../../routes/name.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../../../group/app/page/create_group_page.dart';
import '../../../home/app/pages/create_parish_page.dart';
import '../../../parishioner/app/page/create_parishioner_page.dart';
import '../../../users/app/bloc/user_auth_bloc.dart';
import '../../../users/app/bloc/user_auth_event.dart';
import '../../../users/app/bloc/user_auth_state.dart';

class AuthOnboardingPage extends StatefulWidget {
  const AuthOnboardingPage({Key? key}) : super(key: key);

  @override
  State<AuthOnboardingPage> createState() => _AuthOnboardingPageState();
}

class _AuthOnboardingPageState extends State<AuthOnboardingPage> {

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
    "Parishioner"
  ];

  //Error text
  String errorText = "";

  //Success message
  String msg = "";

  String email = "";
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
    return BlocListener<UserAuthBloc, UserAuthState>(
        listener: (context, state) {
      if (state is UserLoginLoading) {
        setState(() {
          action = AuthAction.LOGIN;
          signingIn = true;
          signingInError = false;
          errorText = "";
        });
      } else if (state is UserLoginLoaded) {
        setState(() {
          action = AuthAction.LOGIN;
          signingIn = false;
          signingInError = false;
          errorText = "";
        });
        Future.delayed(Duration.zero, () {
          if (mounted) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
          }
        });
      } else if (state is UserLoginError) {
        setState(() {
          action = AuthAction.LOGIN;
          signingIn = false;
          signingInError = true;
          errorText = "";
        });
        Future.delayed(const Duration(seconds: 1)).then((value) => {
          if (context.mounted)
            {
              showCustomTopSnackBar(context,
                  message: state.failure.message, color: Colors.red)
            }
        });
      } else if (state is UserAccountPreviewLoading) {
        setState(() {
          action = AuthAction.VERIFY;
          checkInUser = true;
          checkError = false;
          errorText = "";
        });
      } else if (state is UserAccountPreviewLoaded) {
        setState(() {
          action = AuthAction.VERIFY;
          checkInUser = false;
          checkError = false;
          errorText = "";
        });
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
       setState(() {
         action = AuthAction.VERIFY;
         checkError = false;
         checkInUser = false;
         errorText = "";
       });

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
    },
    child:  SafeArea(
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
                        padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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

                                  Visibility(
                                    visible: action == AuthAction.VERIFY ||
                                        action == AuthAction.LOGIN,
                                    child: buildInputFields(size,false, "Email",
                                        "Enter your Email", false, (value) {
                                          email = value;
                                          if (action == AuthAction.VERIFY) {
                                            if (value.endsWith(".com")) {
                                              FocusManager.instance.primaryFocus!.unfocus();
                                              Future.delayed(
                                                  const Duration(seconds: 1))
                                                  .then((value) {
                                                performVerification();
                                              });
                                            }
                                          }
                                        }),
                                  ),
                                  Positioned(
                                    top: 30,
                                    left: 150,
                                    child: Center(
                                      child: Visibility(
                                          visible: checkInUser,
                                          child: buildLoadingIndicator()),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              Visibility(
                                visible: action == AuthAction.LOGIN,
                                child: buildInputFields(size,false, "Password",
                                    "Enter your Password", true, (value) {
                                      password = value;
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
    ));
  }

  Widget buildDropDownButton2() {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 3))
          ]),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          iconStyleData: const IconStyleData(iconSize: 30),
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
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3))
                ]),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
  }

  void performRegistration(String action) {
    if (action == "Parish") {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CreateParishPage()));
    } else if (action == "Group") {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CreateGroupPage()));
    } else if (action == "Diocese") {
      toastInfo(msg: "Want to create a Diocese");
    }else if (action == "Parishioner") {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CreateParishionerPage()));
    }
  }

  void performLogin() {
    if (email.isEmptyOrNull) {
      showCustomTopSnackBar(context, message: 'Email required');
    } else if (password.isEmptyOrNull) {
      showCustomTopSnackBar(context, message: 'Password required');
    } else {
      BlocProvider.of<UserAuthBloc>(context)
          .add(UserLoginEvent(email: email, password: password));
    }
  }

  void forgotPassword(){
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.FORGOT_PASSWORD, (route) => false);
  }

  void performVerification() {
    BlocProvider.of<UserAuthBloc>(context)
        .add(UserAccountPreviewEvent(email: email));
  }

}

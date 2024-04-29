import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/blocs/auth/login_bloc.dart';
import 'package:parish_aid_admin/controller/auth/auth_controller.dart';
import 'package:parish_aid_admin/events/auth/login_events.dart';
import 'package:parish_aid_admin/states/auth/login_state.dart';

import '../../animation/custome_animation.dart';
import '../../animation/rotation_animation.dart';
import '../../widgets/auth/auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Scaffold(
          backgroundColor: Color(0xFFF1F3F6),
          body: Stack(
            children: [
              Visibility(
                  visible: state.showLoadingBar,
                  child: const RotationTransitionExample()),
              SafeArea(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 100),
                    //horizontal: ScreenUtil().setWidth(120)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Visibility(
                            visible: state.showPassword,
                            child: Text(
                              state.isLoginState ? "Login" : "Sign Up",
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
                          visible:
                              ((!state.isLoginState) && state.showPassword),
                          child: Stack(
                            children: <Widget>[
                              buildTextField("First Name", "", (value) {
                                context
                                    .read<LoginBloc>()
                                    .add(FirstNameEvent(value));
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Visibility(
                          visible:
                              ((!state.isLoginState) && state.showPassword),
                          child: Stack(
                            children: <Widget>[
                              buildTextField("Last Name", "", (value) {
                                context
                                    .read<LoginBloc>()
                                    .add(LastNameEvent(value));
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Stack(
                          children: <Widget>[
                            buildTextField("Email", "", (value) {
                              context.read<LoginBloc>().add(EmailEvent(value));

                              if (!state.showPassword) {
                                if (value.endsWith(".com")) {
                                  Future.delayed(const Duration(seconds: 1))
                                      .then((value) => {
                                            AuthController(context: context)
                                                .handlePreview(),
                                            print(value)
                                          });
                                }
                              }
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Visibility(
                            visible: false, child: buildLoadingIndicator()),
                        Visibility(
                          visible: false,
                          child: GestureDetector(
                            onTap: () async {
                              AuthController(context: context).handlePreview();
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
                          visible: state.showPassword,
                          child:
                              buildTextField("Password", "password", (value) {
                            context.read<LoginBloc>().add(PasswordEvent(value));
                            print(value);
                          }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Visibility(
                          visible: state.showPassword,
                          child: GestureDetector(
                            onTap: () {
                              if (state.isLoginState) {
                                AuthController(context: context).handleLogin();
                              } else {
                                AuthController(context: context)
                                    .handleRegistration();
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
                                        color:
                                            Color(0xFF4D70A6).withOpacity(0.2),
                                        blurRadius: 16),
                                    const BoxShadow(
                                        offset: Offset(-10, -10),
                                        color:
                                            Color.fromARGB(170, 255, 255, 255),
                                        blurRadius: 10),
                                  ]),
                              child: Text(
                                state.isLoginState ? "Login" : "Sign Up",
                                style: const TextStyle(
                                    color: Color(0xFF4D70A6), fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ));
    });
  }
}

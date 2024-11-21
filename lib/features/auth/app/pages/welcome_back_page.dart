import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_bloc.dart';
import 'package:parish_aid_admin/features/users/app/bloc/user_auth_state.dart';
import 'package:parish_aid_admin/features/auth/data/models/auth_user_model.dart';

import '../../../../core/utils/urls.dart';
import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../routes/name.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../users/app/bloc/user_auth_event.dart';
import '../widgets/auth_page_widgets.dart';

class WelcomeBackPage extends StatefulWidget {
  const WelcomeBackPage({Key? key,this.user}) : super(key: key);

  final UserResponse? user;

  @override
  State<WelcomeBackPage> createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  bool loading = false;
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<UserAuthBloc,UserAuthState>(listener: (context,state){
      if(state is UserLoginLoading){
        setState(() {
          loading = true;
        });
      }else if(state is UserLoginLoaded){
        setState(() {
          loading = false;
          Future.delayed(Duration.zero, () {
            if (mounted) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
            }
          });
        });
      }else if(state is UserLoginError){
        setState(() {
          loading = false;

          Future.delayed(const Duration(seconds: 1)).then((value) => {
            if (context.mounted)
              {
                showCustomTopSnackBar(context,
                    message: state.failure.message, color: Colors.red)
              }
          });
        });
      }
    },
    child: SafeArea(
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
                                height: size.height * 0.02,
                              ),
                              richText(
                                  "Welcome back",
                                      14),
                              richText(
                                  "(${widget.user!.email})",
                                  8),

                              SizedBox(
                                height: size.height * 0.05,
                              ),
                                buildInputFields(size,false, "Password",
                                    "Enter your Password", true, (value) {
                                      password = value;
                                    }),
                              SizedBox(
                                height: size.height * 0.03,
                              ),

                              //remember & forget text
                              buildRememberForgetSection(()=>forgotPassword()),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              //sign in button
                               GestureDetector(
                                  onTap: () {
                                    performLogin();
                                  },
                                  child: Stack(
                                    children: [
                                      triggerActionButtonBlue(
                                          size,
                                          "Login"),
                                      Positioned(
                                        bottom: 15,
                                        left: 90,
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
    ));
  }

  void performLogin() {
    if (widget.user!.email.isEmptyOrNull) {
      showCustomTopSnackBar(context, message: 'Unable to retrieved the stored email');
    } else if (password.isEmptyOrNull) {
      showCustomTopSnackBar(context, message: 'Password required');
    } else {
      BlocProvider.of<UserAuthBloc>(context)
          .add(UserLoginEvent(email: widget.user!.email!, password: password));
    }
  }

  void forgotPassword(){
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.FORGOT_PASSWORD, (route) => false);
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parish_aid_admin/core/utils/urls.dart';
import 'package:parish_aid_admin/features/auth/app/pages/welcome_back_page.dart';
import 'package:parish_aid_admin/features/onboarding/app/pages/auth_onboarding_page.dart';
import 'package:parish_aid_admin/features/users/data/sources/user_auth_local_source.dart';

import '../../../../core/helpers/custom_widgets.dart';
import '../../../../injection_container.dart';
import '../widgets/auth_page_widgets.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  bool showLogo = false;
  bool showButton = false;


  @override
  void initState() {
    startAnimations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
            // appBar: AppBar(
            //   systemOverlayStyle: SystemUiOverlayStyle.dark,
            //   backgroundColor: Colors.blue.shade900.withOpacity(0.9),
            //   elevation: 0.0,
            //   toolbarHeight: 0,
            // ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Urls.defaultBackgroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: Colors.blue.shade900.withOpacity(0.7),
                ),
                const SizedBox(height: 65),
                Positioned(
                  top: 220,
                  left: 50,
                  right: 50,
                  child: Visibility(
                    visible: showLogo,
                    child: Center(
                        child: SizedBox(
                            height: 270,
                            width: 260,
                            child: Image.asset(
                                Urls.parishAidWTransAsset))),
                  ),
                ),
                Visibility(
                  visible: showButton,
                  child: Positioned(
                      left: 50,
                      right: 50,
                      bottom: 100,
                      child: GestureDetector(
                        onTap: () {
                          //getParishioners();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AuthOnboardingPage(),
                            ),
                          );
                        },
                        child: triggerActionButtonWhite(size, "Get Started",
                            color: Colors.white),
                      )),
                )
              ],
            )
      ),
    );
  }

  static Future<void> delay() async {
    await Future.delayed(const Duration(milliseconds: 350));
  }

  void startAnimations() async {
    await delay();

    setState(() => showLogo = true);
    await delay();

    setState(() => showButton = true);
    await delay();
  }


}

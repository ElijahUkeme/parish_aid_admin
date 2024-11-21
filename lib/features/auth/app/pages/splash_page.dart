import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/auth/app/pages/welcome_back_page.dart';
import 'package:parish_aid_admin/features/auth/app/pages/welcome_page.dart';

import '../../../../core/helpers/custom_widgets.dart';
import '../../../../injection_container.dart';
import '../../../users/data/sources/user_auth_local_source.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    _checkUserAuthentication();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
    );
  }

  Future<void> _checkUserAuthentication() async {
    // Wait for the async operation to complete before navigating
    final userData = await sl<UserAuthLocalSource>().getCachedAuthUser();

    // If user data is found (user is authenticated)
    if (userData?.user != null) {
      pp('Route welcome back ');
      // Navigate to the WelcomeBackPage immediately after checking
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WelcomeBackPage(user: userData!.user)),
      );
    } else {
      pp('Empty user route');
      // Otherwise, navigate to the onBoarding page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
      );
    }
  }
}

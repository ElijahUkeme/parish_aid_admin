import 'package:flutter/material.dart';

import '../../../../core/helpers/txt.dart';
import '../../../../core/utils/color.dart';
import '../../../onboarding/app/pages/navigation_drawer_page.dart';

class AuthHomePage extends StatefulWidget {
  const AuthHomePage({super.key});

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Txt(text: 'Double card example'),
      backgroundColor: Colorz.complexDrawerBlack,
    );
  }

  Widget body() {
    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NavigationDrawerPage(),
              ),
            );
          },
          // child: DoubleCard(
          //   color: color,
          // ),
        );
      },
    );
  }

  static final List<Color> colors = [
    Colorz.doubleCardBlue,
    Colors.teal,
    Colorz.complexDrawerBlueGrey,
    Colors.pink,
    Colors.amber,
  ];
}

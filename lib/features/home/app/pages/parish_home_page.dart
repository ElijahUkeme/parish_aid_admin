import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';

import '../../../onboarding/app/pages/navigation_drawer_page.dart';

class ParishHomePage extends StatefulWidget {
  final Parish parish;
  const ParishHomePage(
      {super.key, required this.parish});

  @override
  State<ParishHomePage> createState() => _ParishHomePageState();
}

class _ParishHomePageState extends State<ParishHomePage> {
  String? parishCoverImage;
  final Color color = Colors.blue.shade900.withOpacity(0.8);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      //drawer: ComplexDrawerUI(),
      drawer:  ComplexDrawer(parish: widget.parish),
      drawerScrimColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900.withOpacity(0.8),
        toolbarHeight: 40,
        elevation: 0.0,
        //iconTheme: const IconThemeData(
          //  color: Colors.white
        ),
    );
  }



}

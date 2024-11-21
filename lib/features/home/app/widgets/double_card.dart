import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/home/app/widgets/parish_card_details_widget.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';

import '../pages/parish_home_page.dart';

class DoubleCard extends StatelessWidget {

  final Color color = Colors.blue.shade900.withOpacity(0.8);
  final Parish parish;

  DoubleCard({Key? key, required this.parish}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return ParishHomePage(
              parish: parish
            );
          }));
        },
        child: Card(
            elevation: 8,
            shadowColor: color,
            child: Column(
              children: <Widget>[

                topCard(context,parish.email!),
                bottomCard(parish.name!, parish.address!)
              ],
            )),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/users/app/pages/details_page.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';
import 'package:parish_aid_admin/widgets/auth/auth_widgets.dart';

import '../../../../core/helpers/txt.dart';
import '../../../../core/helpers/widget.dart';
import '../../../../core/utils/color.dart';
import '../../../users/app/widgets/top_card_widget.dart';

class DoubleCard extends StatelessWidget {
  ///Custom primary color of the widget
  final Color color = Colors.blue.shade900.withOpacity(0.8);
  final UserAccountFetchModel userAccountFetchModel;
  int dataLength = 0;

  ///Constructor
  DoubleCard({Key? key, required this.userAccountFetchModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (var i = 0;
        i < userAccountFetchModel.response!.data!.parish!.length;
        i++) {
      dataLength = i;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return ParishDetailsPage(
              userAccountFetchModel: userAccountFetchModel,
              index: dataLength,
            );
          }));
        },
        child: Card(
            elevation: 8,
            shadowColor: color,
            child: Column(
              children: <Widget>[
                ///Here we split the card into two segments:
                top(
                    context,
                    color,
                    "Parish Id: ${userAccountFetchModel.response!.data!.parish![dataLength].parishId}",
                    "Email: ${userAccountFetchModel.response!.data!.parish![dataLength].email}"),
                bottom(),
              ],
            )),
      ),
    );
  }

  ///Top layer of the card
  Widget tops(BuildContext context) {
    final Color backgroundColor = color;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: backgroundColor.withOpacity(0.1),
      ),
      child: ListTile(
        // leading: null,///You can use if you want;
        title: Txt(
          text:
              "Parish Id: ${userAccountFetchModel.response!.data!.parish![dataLength].parishId}",
          fontWeight: FontWeight.bold,
        ),
        subtitle: Txt(
            text:
                "Email: ${userAccountFetchModel.response!.data!.parish![dataLength].email}"),
        trailing: CircleAvatar(
          backgroundColor: color,
          child: const Icon(
            Icons.login,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  ///Bottom layer of the card
  Widget bottom() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),
      child: ListTile(
        title: Txt(
          text:
              "Name: ${userAccountFetchModel.response!.data!.parish![dataLength].name}",
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        subtitle: Txt(
          text:
              "Address: ${userAccountFetchModel.response!.data!.parish![dataLength].address}",
          color: Colors.white,
        ),
      ),
    );
  }
}

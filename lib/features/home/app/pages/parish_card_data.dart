import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/home/app/pages/parish_details_page.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart' as pModel;

import '../widgets/parish_card_details_widget.dart';

class ParishCardData extends StatelessWidget {

  final Color color = Colors.blue.shade900.withOpacity(0.8);
  final pModel.ParishData parishData;
   ParishCardData({Key? key,required this.parishData}) : super(key: key);


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
            return ParishDetailPage(
              parishData: parishData
            );
          }));
        },
        child: Card(
            elevation: 8,
            shadowColor: color,
            child: Column(
              children: <Widget>[
                ///Here we split the card into two segments:
                topCard(context,
                    parishData.email!),

                bottomCard(parishData.name!,
                    parishData.address!),
              ],
            )),
      ),
    );
  }
}

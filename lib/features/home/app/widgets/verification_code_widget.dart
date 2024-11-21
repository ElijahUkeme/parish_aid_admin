import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/home/app/pages/verification_code_details_page.dart';
import 'package:parish_aid_admin/features/home/app/widgets/vcode_widgets.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';

class VerificationCodeWidget extends StatelessWidget{
   VerificationCodeWidget({super.key,required this.data});

  final VerificationCodeData data;
  final Color color = Colors.blue.shade900.withOpacity(0.8);

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
            return VerificationCodeDetailsPage(
                data: data
            );
          }));
        },
        child: Card(
            elevation: 8,
            shadowColor: color,
            child: Column(
              children: <Widget>[
                ///Here we split the card into two segments:
                ///
                vCodeTopCard(context, '${data.id}'),
                vCodeBottomCard('${data.code}', data.batchNo??'')
              ],
            )),
      ),
    );
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_stat_model.dart';

import '../../../billing/app/widget/billing_plans_widget.dart';

class VerificationCodeStatCard extends StatelessWidget {
  VerificationCodeStatCard({Key? key,this.data}) : super(key: key);
  final VerificationCodeStatData? data;


  final Color color = Colors.blue.shade900.withOpacity(0.8);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 0,
      ),
        child: Card(
            elevation: 8,
            shadowColor: color,
            child: Column(
              children: <Widget>[
                customTopCard(context,'Title: ${data!.title}', 'Count: ${data!.count.toString()}')
              ],
            )),
    );
  }
}

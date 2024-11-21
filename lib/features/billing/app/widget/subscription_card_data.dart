import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/billing/app/pages/get_subscription_details_page.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';

import 'billing_plans_widget.dart';

class SubscriptionCardData extends StatelessWidget {
   SubscriptionCardData({Key? key,this.model}) : super(key: key);

  final SubscriptionModel? model;
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
            return GetSubscriptionDetailsPage(model: model!);
          }));
        },
        child: Card(
            elevation: 8,
            shadowColor: color,
            child: Column(
              children: <Widget>[
                ///Here we split the card into two segments:
                ///
                customTopCard(context,'View subscription details', 'Subscription Id: ${model!.id.toString()}'),
                customBottomCard('Type: ${model!.type}', 'Status: ${model!.status}')
              ],
            )),
      ),
    );
  }
}

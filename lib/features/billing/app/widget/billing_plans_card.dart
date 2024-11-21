import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/billing/app/pages/get_billing_plans_details_page.dart';
import 'package:parish_aid_admin/features/billing/app/widget/billing_plans_widget.dart';
import 'package:parish_aid_admin/features/billing/data/models/billing_plans_model.dart';

class BillingPlansCard extends StatelessWidget {
    BillingPlansCard({Key? key,this.billings}) : super(key: key);

  final BillingPlansModel? billings;
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
            return GetBillingPlansDetailsPage(model: billings!);
          }));
        },
        child: Card(
            elevation: 8,
            shadowColor: color,
            child: Column(
              children: <Widget>[
                ///Here we split the card into two segments:
                ///
                customTopCard(context,'View billing details', 'Billing Id: ${billings!.id.toString()}'),
                customBottomCard('Name: ${billings!.name}', 'Description: ${billings!.description}')
              ],
            )),
      ),
    );
  }
}

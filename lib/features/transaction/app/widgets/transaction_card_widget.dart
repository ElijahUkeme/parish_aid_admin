import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/transaction/app/pages/transaction_details_page.dart';
import 'package:parish_aid_admin/features/transaction/data/model/transaction_model.dart';

import '../../../../core/utils/app_data_formatter.dart';
import '../../../../core/utils/app_styles.dart';

class TransactionCardWidget extends StatelessWidget {
  const TransactionCardWidget({Key? key, required this.transaction}) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return TransactionDetailsPage(transaction: transaction);
        }));
      },
      child: Card(
          elevation: 0.0,
          margin: const EdgeInsets.only(left: 10,right: 10),
          clipBehavior: Clip.hardEdge,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text('Amount: $addNairaToAmount(${transaction.amount.toString()})',
                        style: TextStyles.h4.copyWith(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        )),
                    Text(
                      'Created Date: $formatDate(${transaction.createdAt})',
                      style: TextStyles.h4.copyWith(
                        fontSize: 12,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      'Status: ${transaction.status}',
                      style: TextStyles.h4.copyWith(
                        fontSize: 12,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade100,
                    )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}

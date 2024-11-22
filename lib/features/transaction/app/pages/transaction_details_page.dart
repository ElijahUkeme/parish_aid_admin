import 'package:flutter/material.dart';
import 'package:parish_aid_admin/core/utils/app_styles.dart';
import 'package:parish_aid_admin/features/transaction/data/model/transaction_model.dart';

import '../../../../core/utils/app_data_formatter.dart';
import '../../../home/app/widgets/details_page_widget.dart';

class TransactionDetailsPage extends StatefulWidget {
  const TransactionDetailsPage({Key? key, required this.transaction}) : super(key: key);

  final TransactionModel transaction;

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0.0,
      iconTheme:  IconThemeData(color: Colors.blue.shade900.withOpacity(0.9)),
      backgroundColor: Colors.white,
      centerTitle: false,
      titleTextStyle: context.toolBarTitleStyle,
      title: const Text('Transaction Details'),
    );
  }

  Widget pageBody(Size size){
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white.withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Type",
                      widget.transaction.type??''),
                  detailsPageTextEnd(
                      "Batch Number",
                      widget.transaction.batchNo??''),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Amount",
                      addNairaToAmount(widget.transaction.amount.toString())),
                  detailsPageTextEnd(
                      "Description",
                      widget.transaction.description??'')
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Date",
                      formatDate(widget.transaction.createdAt!)),
                  detailsPageTextEnd(
                      "Status",
                      widget.transaction.status??'')
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Reference",
                      widget.transaction.reference??''),
                  detailsPageTextEnd(
                      "Transaction Type",
                      widget.transaction.transactionType??''),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

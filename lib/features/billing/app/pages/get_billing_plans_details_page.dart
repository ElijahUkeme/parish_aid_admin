import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/core/utils/app_utils.dart';
import 'package:parish_aid_admin/features/billing/data/models/billing_plans_model.dart';

import '../../../home/app/widgets/details_page_widget.dart';

class GetBillingPlansDetailsPage extends StatefulWidget {
  const GetBillingPlansDetailsPage({Key? key,required this.model}) : super(key: key);
  final BillingPlansModel model;

  @override
  State<GetBillingPlansDetailsPage> createState() => _GetBillingPlansDetailsPageState();
}

class _GetBillingPlansDetailsPageState extends State<GetBillingPlansDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(),
      body: pageBody(size),
    );
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: const IconThemeData(
          color: Colors.white
      ),
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
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
                      "Billing plans Id",
                      widget.model.id.toString()??''),
                  detailsPageTextEnd(
                      "Name",
                      widget.model.name??''),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Description",
                      widget.model.description??''),
                  detailsPageTextEnd(
                      "Type",
                      widget.model.type??''),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Frequency",
                      widget.model.frequency??''),
                  detailsPageTextEnd(
                      "Price",
                      widget.model.price.toString()??''),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Duration",
                      widget.model.duration.toString()??''),
                  detailsPageTextEnd(
                      "Target",
                      widget.model.target??''),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Status",
                      widget.model.status??''),
                  detailsPageTextEnd(
                      "Created At",
                      splitDateTime(widget.model.createdAt!))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     detailsPageTextStart(
              //         "Phone Number",
              //         widget.data.parish!.phoneNo!),
              //     detailsPageTextEnd(
              //         "Parish Priest Name",
              //         widget.data.parish!.parishPriestName!)
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     detailsPageTextStart(
              //         "Parish Id",
              //         widget.data.parish!.uuid!),
              //     detailsPageTextEnd(
              //         "Town",
              //         widget.data.parish!.town!.name!)
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     detailsPageTextStart(
              //         "State",
              //         widget.data.parish!.state!.name!),
              //     detailsPageTextEnd(
              //         "Country",
              //         widget.data.parish!.country!.name!)
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     detailsPageTextStart(
              //         "Diocese",
              //         widget.data.parish!.diocese!.name!),
              //     detailsPageTextEnd(
              //         "Phone No.",
              //         widget.data.parish!.diocese!.phoneNo!)
              //   ],
              // ),
              //
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     detailsPageTextStart(
              //         "Status",
              //         widget.data.parish!.status!),
              //     detailsPageTextEnd(
              //         "Type",
              //         widget.data.parish!.type!)
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     detailsPageText(
              //         "Province",
              //         widget
              //             .userAccountFetchModel
              //             .response!
              //             .data!
              //             .parish![widget.index]
              //             .diocese!
              //             .province!
              //             .name!),
              //     detailsPageText(
              //         "Bishop Name",
              //         widget.userAccountFetchModel.response!.data!
              //             .parish![widget.index].diocese!.bishopName!)
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

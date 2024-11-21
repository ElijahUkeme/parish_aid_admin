import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/core/utils/app_utils.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';

import '../../../home/app/widgets/details_page_widget.dart';

class GetSubscriptionDetailsPage extends StatefulWidget {
  const GetSubscriptionDetailsPage({Key? key,required this.model}) : super(key: key);
  final SubscriptionModel model;

  @override
  State<GetSubscriptionDetailsPage> createState() => _GetSubscriptionDetailsPageState();
}

class _GetSubscriptionDetailsPageState extends State<GetSubscriptionDetailsPage> {
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
                      "Subscription plans Id",
                      widget.model.id.toString()??''),
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
                      "Price",
                      widget.model.price.toString()??''),
                  detailsPageTextEnd(
                      "Paid On",
                      widget.model.paidOn??''),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Expires At",
                      widget.model.expiresAt??''),
                  detailsPageTextEnd(
                      "Status",
                      widget.model.status??''),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Created At",
                      splitDateTime(widget.model.createdAt!)),
                  detailsPageTextEnd(
                      "Updated At",
                      splitDateTime(widget.model.updatedAt!)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "User First Name",
                      widget.model.user!.firstName??''),
                  detailsPageTextEnd(
                      "Created At",
                      splitDateTime(widget.model.user!.createdAt!))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Phone Number",
                      widget.model.user!.phoneNumber??''),
                  detailsPageTextEnd(
                      "Email",
                      widget.model.user!.email??'')
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Updated At",
                      splitDateTime(widget.model.user!.updatedAt!)),
                  detailsPageTextEnd(
                      "Id",
                      widget.model.user!.id.toString())
                ],
              ),
              const SizedBox(
                height: 10,
              ),
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

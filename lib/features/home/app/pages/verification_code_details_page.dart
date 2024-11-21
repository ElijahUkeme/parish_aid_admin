import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/core/utils/app_utils.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';

import '../widgets/details_page_widget.dart';

class VerificationCodeDetailsPage extends StatefulWidget {
  const VerificationCodeDetailsPage({Key? key,required this.data}) : super(key: key);

  final VerificationCodeData data;

  @override
  State<VerificationCodeDetailsPage> createState() => _VerificationCodeDetailsPageState();
}

class _VerificationCodeDetailsPageState extends State<VerificationCodeDetailsPage> {
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
                      "Verification code Id",
                      widget.data.id.toString()??''),
                  detailsPageTextEnd(
                      "Code",
                      widget.data.code.toString()??''),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Batch Number",
                      widget.data.batchNo??''),
                  detailsPageTextEnd(
                      "Tags",
                      widget.data.tags??''),
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
                      splitDateTime(widget.data.createdAt!)),
                  detailsPageTextEnd(
                      "Expires At",
                      splitDateWithoutT(widget.data.expiresAt!)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Parish Name",
                      widget.data.parish!.name!),
                  detailsPageTextEnd(
                      "Acronym",
                      widget.data.parish!.acronym!),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Email",
                      widget.data.parish!.email!),
                  detailsPageTextEnd(
                      "Address",
                      widget.data.parish!.address!)
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
                      widget.data.parish!.phoneNo!),
                  detailsPageTextEnd(
                      "Parish Priest Name",
                      widget.data.parish!.parishPriestName!)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Parish Id",
                      widget.data.parish!.uuid!),
                  detailsPageTextEnd(
                      "Town",
                      widget.data.parish!.town!.name!)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "State",
                      widget.data.parish!.state!.name!),
                  detailsPageTextEnd(
                      "Country",
                      widget.data.parish!.country!.name!)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsPageTextStart(
                      "Diocese",
                      widget.data.parish!.diocese!.name!),
                  detailsPageTextEnd(
                      "Phone No.",
                      widget.data.parish!.diocese!.phoneNo!)
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
                      widget.data.parish!.status!),
                  detailsPageTextEnd(
                      "Type",
                      widget.data.parish!.type!)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
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

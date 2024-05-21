import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/features/home/app/widgets/txt.dart';
import 'package:parish_aid_admin/features/users/app/widgets/top_card_widget.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';

import '../../../../core/helpers/image_processors.dart';
import '../../../../core/utils/urls.dart';

class ParishDetailsPage extends StatefulWidget {
  final UserAccountFetchModel userAccountFetchModel;
  final int index;
  const ParishDetailsPage(
      {super.key, required this.userAccountFetchModel, required this.index});

  @override
  State<ParishDetailsPage> createState() => _ParishDetailsPageState();
}

class _ParishDetailsPageState extends State<ParishDetailsPage> {
  String? parishCoverImage;
  final Color color = Colors.blue.shade900.withOpacity(0.8);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: !parishCoverImage.isEmptyOrNull
                    ? loadImageWidget(parishCoverImage!)
                    : Image.asset(
                        Urls.defaultBackgroundImage,
                        fit: BoxFit.cover,
                      ),
              ),
              Container(
                height: size.height,
                width: size.width,
                color: Colors.white.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          detailsPageTextStart(
                              "Name",
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].name!),
                          detailsPageTextEnd(
                              "Acronym",
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].acronym!),
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
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].email!),
                          detailsPageTextEnd(
                              "Address",
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].address!)
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
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].phoneNo!),
                          detailsPageTextEnd(
                              "Parish Priest Name",
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].parishPriestName!)
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
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].parishId!),
                          detailsPageTextEnd(
                              "Town",
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].town!.name!)
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
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].state!.name!),
                          detailsPageTextEnd(
                              "Country",
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].country!.name!)
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
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].diocese!.name!),
                          detailsPageTextEnd(
                              "Diocese Phone No.",
                              widget.userAccountFetchModel.response!.data!
                                  .parish![widget.index].diocese!.phoneNo!)
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget detailsPageTextStart(String firstText, String secondText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Txt(text: firstText, fontWeight: FontWeight.bold),
        Txt(text: secondText)
      ],
    );
  }

  Widget detailsPageTextEnd(String firstText, String secondText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Txt(text: firstText, fontWeight: FontWeight.bold),
        Txt(text: secondText)
      ],
    );
  }
}

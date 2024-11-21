import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart' as pModel;

import '../widgets/details_page_widget.dart';

class ParishDetailPage extends StatefulWidget {
  const ParishDetailPage({Key? key,required this.parishData}) : super(key: key);
  final pModel.ParishData parishData;

  @override
  State<ParishDetailPage> createState() => _ParishDetailPageState();
}

class _ParishDetailPageState extends State<ParishDetailPage> {
  @override
  Widget build(BuildContext context) {
    print("The sent parish is now ${widget.parishData.address}");
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: appBar(),
      body: widget.parishData ==null?Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue.shade900.withOpacity(0.8),
          ),
        ),
      ):pageBody(size),
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
                      "Name",
                      widget.parishData.name!),
                  detailsPageTextEnd(
                      "Acronym",
                      widget.parishData.acronym!),
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
                      widget.parishData.email!),
                  detailsPageTextEnd(
                      "Address",
                      widget.parishData.address!)
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
                      widget.parishData.phoneNo!),
                  detailsPageTextEnd(
                      "Parish Priest Name",
                      widget.parishData.parishPriestName!)
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
                      widget.parishData.uuid!),
                  detailsPageTextEnd(
                      "Town",
                      widget.parishData.town!.name!)
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
                      widget.parishData.state!.name!),
                  detailsPageTextEnd(
                      "Country",
                      widget.parishData.country!.name!)
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
                      widget.parishData.diocese!.name!),
                  detailsPageTextEnd(
                      "Phone No.",
                      widget.parishData.diocese!.phoneNo!)
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
                      widget.parishData.status!),
                  detailsPageTextEnd(
                      "Type",
                      widget.parishData.type!)
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

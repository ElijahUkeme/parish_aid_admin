import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';

import '../../../home/app/widgets/details_page_widget.dart';

class ShowGroupDetailPage extends StatefulWidget {
  const ShowGroupDetailPage({Key? key,required this.groupData}) : super(key: key);
  final GroupData groupData;

  @override
  State<ShowGroupDetailPage> createState() => _ShowGroupDetailPageState();
}

class _ShowGroupDetailPageState extends State<ShowGroupDetailPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(),
      body: widget.groupData ==null?Container(
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailsPageTextStart(
                    "Name",
                    widget.groupData.name!),
                detailsPageTextEnd(
                    "Acronym",
                    widget.groupData.acronym!),
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
                    widget.groupData.email!),
                detailsPageTextEnd(
                    "UUid",
                    widget.groupData.uuid!)
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
                    widget.groupData.phoneNo!),
                detailsPageTextEnd(
                    "Category",
                    widget.groupData.category!)
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
                    widget.groupData.status!),
                detailsPageTextEnd(
                    "Town",
                    widget.groupData.town!.name!)
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
                    widget.groupData.state!.name!),
                detailsPageTextEnd(
                    "Country",
                    widget.groupData.country!.name!)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailsPageTextStart(
                    "Lga",
                    widget.groupData.lga!.name!),
                detailsPageTextEnd(
                    "Type",
                    widget.groupData.type!)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

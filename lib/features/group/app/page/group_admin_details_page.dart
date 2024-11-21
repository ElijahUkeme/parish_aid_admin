import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/group/data/model/group_admin_model.dart';

import '../../../home/app/widgets/details_page_widget.dart';

class GroupAdminDetailsPage extends StatefulWidget {
  const GroupAdminDetailsPage({Key? key,required this.data}) : super(key: key);

  final GroupAdminData data;

  @override
  State<GroupAdminDetailsPage> createState() => _GroupAdminDetailsPageState();
}

class _GroupAdminDetailsPageState extends State<GroupAdminDetailsPage> {
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailsPageTextStart(
                    "Name",
                    widget.data.group!.name!),
                detailsPageTextEnd(
                    "Acronym",
                    widget.data.group!.acronym!),
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
                    widget.data.group!.email!),
                detailsPageTextEnd(
                    "UUid",
                    widget.data.group!.uuid!)
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
                    widget.data.group!.phoneNo!),
                detailsPageTextEnd(
                    "Type",
                    widget.data.group!.category!)
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
                    widget.data.status!),
                detailsPageTextEnd(
                    "Town",
                    widget.data.group!.town!.name!)
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
                    widget.data.group!.lga!.name!),
                detailsPageTextEnd(
                    "State",
                    widget.data.group!.state!.name!)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailsPageTextStart(
                    "Country",
                    widget.data.group!.country!.name!),
                detailsPageTextEnd(
                    "Username",
                  widget.data.user!.firstName!
                    )
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
                    widget.data.user!.email!),
                detailsPageTextEnd(
                    "Phone Number",
                    widget.data.user!.phoneNumber??'')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailsPageTextStart(
                    "Role",
                    widget.data.role!),
                detailsPageTextEnd(
                    "Status",
                    widget.data.status!)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/core/widgets/custom_top_snackbar.dart';
import 'package:parish_aid_admin/features/group/app/page/group_admin_details_page.dart';
import 'package:parish_aid_admin/features/group/app/page/update_group_admin_page.dart';
import 'package:parish_aid_admin/features/group/data/model/group_admin_model.dart';

import '../../../../core/helpers/txt.dart';
import 'group_card_details_widget.dart';
import 'group_top_card_widget.dart';
class GroupAdminCard extends StatelessWidget {
  final GroupAdminData data;
  final int? parishId;

  GroupAdminCard({Key? key, required this.data,this.parishId}) : super(key: key);

  final Color color = Colors.blue.shade900.withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return GroupAdminDetailsPage(data: data);
            },
          ));
        },
        child: Card(
          elevation: 8,
          shadowColor: color,
          child: Column(
            children: <Widget>[
              GroupTopCard(
                pId: data.id.toString(),
                emailOrRole: data.role!,
                isAdmin: true,
                onUpdate: _updateGroup,
                onDelete: _deleteGroup,
              ),
              groupBottomCard(data.group!.name!, data.status!),
            ],
          ),
        ),
      ),
    );
  }

  // Update Group function
  void _updateGroup(BuildContext context) {
   Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateGroupAdminPage(data: data,parishId:parishId)));
  }

  void _deleteGroup(BuildContext context) {
    showCustomTopSnackBar(context, message: 'Deletion functionality not yet implemented');
  }
}

Widget groupBottomCard(String name, String status) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 2.5),
    decoration: BoxDecoration(
      color: Colors.blue.shade900.withOpacity(0.8),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    child: ListTile(
      title: Txt(
        text: "Name: $name",
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      subtitle: Txt(
        text: "Status: $status",
        color: Colors.white,
      ),
    ),
  );
}
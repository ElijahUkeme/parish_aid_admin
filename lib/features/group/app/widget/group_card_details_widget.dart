

import 'package:flutter/material.dart';

import '../../../../core/helpers/txt.dart';

class GroupCardDetailsWidget extends StatelessWidget {
   GroupCardDetailsWidget({Key? key, required this.onUpdate, required this.onDelete,
     required this.pId, required this.emailOrRole, required this.isAdmin}) : super(key: key);

  final void Function(BuildContext) onUpdate;
  final void Function(BuildContext) onDelete;
  final String pId;
  final String emailOrRole;
  final bool isAdmin;
  final Color backgroundColor = Colors.blue.shade900.withOpacity(0.8);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: backgroundColor.withOpacity(0.1),
      ),
      child: ListTile(
        title: const Txt(
          text: "View group details",
          fontWeight: FontWeight.bold,
        ),
        subtitle: Txt(text: isAdmin ? "Role: $emailOrRole" : "Email: $emailOrRole"),
        trailing: PopupMenuButton<String>(
          onSelected: (String value) {
            if (value == 'update') {
              onUpdate(context);
            } else if (value == 'delete') {
              onDelete(context);
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'update',
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Update'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
        )),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/txt.dart';

class GroupTopCard extends StatelessWidget {
  final String pId;
  final String emailOrRole;
  final bool isAdmin;
  final void Function(BuildContext) onUpdate;
  final void Function(BuildContext) onDelete;

  const GroupTopCard({
    Key? key,
    required this.pId,
    required this.emailOrRole,
    required this.isAdmin,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Colors.blue.shade900.withOpacity(0.8);

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
        trailing: isAdmin?PopupMenuButton<String>(
          onSelected: (String value) {
            if (value == 'update') {
              onUpdate(context); // Trigger the passed update function
            } else if (value == 'delete') {
              onDelete(context); // Trigger the passed delete function
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
        ):const SizedBox(),
      ),
    );
  }
}
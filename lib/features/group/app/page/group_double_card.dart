import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/group/app/page/delete_group_page.dart';
import 'package:parish_aid_admin/features/group/app/page/show_group_detail_page.dart';
import 'package:parish_aid_admin/features/group/app/page/update_group_page.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';
import '../../../../core/widgets/custom_top_snackbar.dart';
import '../widget/group_card_details_widget.dart';

class GroupDoubleCard extends StatelessWidget {
   GroupDoubleCard({Key? key,required this.groupData}) : super(key: key);

  final Color color = Colors.blue.shade900.withOpacity(0.4);
  final GroupData groupData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 0,
      ),
      child: GestureDetector(
        onTap: () {

          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return ShowGroupDetailPage(
                groupData: groupData
            );

          }));
        },
        child: Card(
            elevation: 8,
            shadowColor: color,
            child: Column(
              children: <Widget>[
                GroupCardDetailsWidget(onUpdate: _updateGroup, onDelete: _deleteGroup, pId: groupData.id.toString(),
                    emailOrRole: groupData.email!, isAdmin: false),
                //groupTopCard(context, groupData.id.toString(), groupData.email!,isAdmin: false),
                groupBottomCard(groupData.name!, groupData.status!)
              ],
            )),
      ),
    );
  }

   // Update Group function
   void _updateGroup(BuildContext context) {
     Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateGroupPage(group: groupData)));
   }

   void _deleteGroup(BuildContext context) {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteGroupPage(groupData: groupData)));
   }

}

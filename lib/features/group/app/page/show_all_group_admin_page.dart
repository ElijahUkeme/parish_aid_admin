import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_event.dart';
import 'package:parish_aid_admin/features/group/app/widget/group_admin_card.dart';

import '../../../../widgets/auth/auth_widgets.dart';
import '../../data/model/group_admin_model.dart';
import '../bloc/group_bloc.dart';
import '../bloc/group_state.dart';

class ShowAllGroupAdminPage extends StatefulWidget {
  const ShowAllGroupAdminPage({Key? key,required this.data,this.parishId}) : super(key: key);

  final List<GroupAdminData> data;
  final int? parishId;



  @override
  State<ShowAllGroupAdminPage> createState() => _ShowAllGroupAdminPageState();
}

class _ShowAllGroupAdminPageState extends State<ShowAllGroupAdminPage> {


  @override
  Widget build(BuildContext context) {
    return buildMainBody();
  }

  Widget buildMainBody() {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [groupData()],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
    );
  }

  Widget groupData() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.data.length,
      itemBuilder: (BuildContext context, int index) {
        return GroupAdminCard(data: widget.data[index],parishId: widget.parishId);
      },
    );
  }

}

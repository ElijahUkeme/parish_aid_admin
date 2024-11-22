import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/group/app/page/group_double_card.dart';

import '../../../../widgets/auth/auth_widgets.dart';
import '../../data/model/group_model.dart';
import '../bloc/group_bloc.dart';
import '../bloc/group_event.dart';
import '../bloc/group_state.dart';

class ShowAllGroupPage extends StatefulWidget {
  const ShowAllGroupPage({Key? key, this.parishId}) : super(key: key);
  final String? parishId;

  @override
  State<ShowAllGroupPage> createState() => _ShowAllGroupPageState();
}

class _ShowAllGroupPageState extends State<ShowAllGroupPage> {
  bool fetchLoading = true;
  bool fetchError = false;
  String errorText = "";
  GroupModel? groupModel;

  @override
  void initState() {
    super.initState();
    showGroups();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
      if (state is GetGroupsLoading) {
        fetchLoading = true;
        fetchError = false;
      } else if (state is GetGroupsLoaded) {
        fetchLoading = false;
        fetchError = false;
        groupModel = state.groupModel;

        if (state.groupModel.response!.data!.isEmpty) {
          toastInfo(msg: "Empty group list");
          Navigator.pop(context);
        }
      } else if (state is GetGroupsError) {
        fetchError = true;
        fetchLoading = false;
        errorText = state.failure.message;
        toastInfo(msg: errorText);
      }
      return fetchLoading
          ? Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue.shade900.withOpacity(0.8),
                ),
              ),
            )
          : buildMainBody();
    });
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
        children: [data()],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
    );
  }

  Widget data() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupModel!.response!.data!.length,
      itemBuilder: (BuildContext context, int index) {
        //final Color color = CardPage.colors[index];
        return GroupDoubleCard(groupData: groupModel!.response!.data![index]);
      },
    );
  }
  void showGroups() {
    BlocProvider.of<GroupBloc>(context)
        .add(GetGroupsEvent(parishId: widget.parishId));
  }
}

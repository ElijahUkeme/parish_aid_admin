import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/widgets/custom_top_snackbar.dart';
import 'package:parish_aid_admin/features/group/app/page/show_all_group_admin_page.dart';

import '../../../../core/helpers/custom_widgets.dart';
import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../../data/model/group_admin_model.dart';
import '../bloc/group_bloc.dart';
import '../bloc/group_event.dart';
import '../bloc/group_state.dart';

class VerifyGroupAdminListPage extends StatefulWidget {
  const VerifyGroupAdminListPage({Key? key,this.parishId}) : super(key: key);

  final int? parishId;

  @override
  State<VerifyGroupAdminListPage> createState() => _VerifyGroupAdminListPageState();
}

class _VerifyGroupAdminListPageState extends State<VerifyGroupAdminListPage> {
  int? groupId;

  bool fetchLoading = false;
  bool fetchError = false;
  String errorText = "";

  List<GroupAdminData> groupsData = [];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<GroupBloc, GroupState>(listener: (context, state) {
      pp(state.runtimeType);
      if (state is GetGroupAdminsLoading) {
        setState(() {
          fetchLoading = true;
          fetchError = false;
        });

      } else if (state is GetGroupAdminsLoaded) {
        setState(() {
          fetchLoading = false;
          fetchError = false;
          groupsData = state.groupsData;

          if (state.groupsData.isEmpty) {
            toastInfo(msg: "Empty group list");
            Navigator.pop(context);
          }else{
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=>ShowAllGroupAdminPage(data: groupsData,parishId: widget.parishId)));
          }
        });
      } else if (state is GetGroupAdminsError) {
        setState(() {
          fetchError = true;
          fetchLoading = false;
          errorText = state.failure.message;
          showCustomTopSnackBar(context, message: state.failure.message);
        });
      }
    },
    child: Scaffold(
        backgroundColor: Colors.blue.shade900.withOpacity(0.8),
        appBar: appBar(),
        body: SafeArea(
          child: SafeArea(
              child: SizedBox(
                  height: size.height,
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Urls.defaultBackgroundImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.blue.shade900.withOpacity(0.6),
                    ),
                    const SizedBox(height: 65),
                    //card and footer ui
                    Center(
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    alignment: Alignment.center,
                                    width: size.width * 0.9,
                                    height: size.height * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          //logo & text
                                          logo(size.height / 10, size.height / 6),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),

                                          const SizedBox(height: 16,),
                                          buildInputFields(size, false, "", "Enter the group Id", false, (value) {
                                            groupId = int.parse(value);
                                          }),
                                          SizedBox(
                                            height: size.height * 0.08,
                                          ),

                                          //sign in button
                                          Visibility(
                                            visible: true,
                                            child: GestureDetector(
                                              onTap: () {
                                                getGroupAdmins();
                                              },
                                              child: Stack(
                                                children: [
                                                  triggerActionButtonBlue(
                                                      size, "Proceed"),
                                                  Positioned(
                                                    bottom: 15,
                                                    left: 70,
                                                    child: Visibility(
                                                      visible: fetchLoading,
                                                      child: buildLoadingIndicator(
                                                          color: Colors.grey
                                                              .withOpacity(0.8)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.04,
                                          ),
                                        ]))
                              ]),
                        ))
                  ]))),
        )));
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 40,
        backgroundColor: Colors.blue.shade900.withOpacity(0.8));
  }

  void getGroupAdmins(){
    if(groupId ==null){
      showCustomTopSnackBar(context, message: 'Enter your group Id');
    }else{
      BlocProvider.of<GroupBloc>(context).add(GetGroupAdminsEvent(widget.parishId,groupId));
    }
  }
}

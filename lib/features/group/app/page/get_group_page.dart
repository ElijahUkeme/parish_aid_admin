import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/widgets/custom_top_snackbar.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_bloc.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_event.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_state.dart';
import 'package:parish_aid_admin/features/group/app/page/show_group_detail_page.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class GetGroupPage extends StatefulWidget {
  const GetGroupPage({Key? key,this.parishId}) : super(key: key);

  final String? parishId;
  @override
  State<GetGroupPage> createState() => _GetGroupPageState();
}

class _GetGroupPageState extends State<GetGroupPage> {


  String groupId = "";
  bool getGroupLoading = false;
  bool getGroupError = false;

  String errorText = "";

  //Success message
  String msg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("The parish Id is ${widget.parishId}");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<GroupBloc,GroupState>(listener: (context,state){
      if(state is GetGroupLoading){
        setState(() {
          getGroupLoading = true;
          getGroupError = false;
          errorText = '';
        });
      }else if(state is GetGroupLoaded){
        setState(() {
          getGroupLoading  = false;
          getGroupError = false;
          errorText = "";

          toastInfo(msg: state.groupModel.response!.message!);
          Future.delayed(const Duration(seconds: 1)).then((value) => {
            if(context.mounted){
              if(state.groupModel.response!.data !=null){
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute<void>(builder: (BuildContext context) {
                  return ShowGroupDetailPage(
                      groupData: state.groupModel.response!.data!
                  );
                }))
              }
            }
          });
        });

      }else if(state is GetGroupError){
        setState(() {
          getGroupLoading = false;
          getGroupError = true;
          errorText = state.failure.message;
          toastInfo(msg: errorText);
        });
      }
    },child: SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue.shade900.withOpacity(0.8),
          //resizeToAvoidBottomInset: false,
          body: SafeArea(
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
                                    height: size.height * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          logo(size.height / 10, size.height / 6),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),

                                          buildInputFields(size, false, "", "Enter the group Id", false, (value) {
                                            groupId = value;
                                          }),
                                          SizedBox(
                                            height: size.height * 0.08,
                                          ),

                                          //sign in button
                                          Visibility(
                                            visible: true,
                                            child: GestureDetector(
                                              onTap: () {
                                                showGroup();
                                              },
                                              child: Stack(
                                                children: [
                                                  triggerActionButtonBlue(
                                                      size, "Proceed"),
                                                  Positioned(
                                                    bottom: 15,
                                                    left: 90,
                                                    child: Visibility(
                                                      visible: getGroupLoading,
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
                                        ])
                                )]),
                        ))
                  ])))),
    ));

  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
      toolbarHeight: 50,
    );
  }
  void showGroup() {
    if(widget.parishId!.isEmpty){
      showCustomTopSnackBar(context, message: "Parish Id was not passed");
    }else if(groupId.isEmpty){
      showCustomTopSnackBar(context, message: "Please Enter the group Id");
    }else{
      BlocProvider.of<GroupBloc>(context).add(GetGroupEvent(groupId: groupId, parishId: widget.parishId));
    }
  }
}

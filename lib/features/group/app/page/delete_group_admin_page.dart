import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_event.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../bloc/group_bloc.dart';
import '../bloc/group_state.dart';

class DeleteGroupAdminPage extends StatefulWidget {
  const DeleteGroupAdminPage({Key? key,this.parishId}) : super(key: key);

  final String? parishId;

  @override
  State<DeleteGroupAdminPage> createState() => _DeleteGroupAdminPageState();
}

class _DeleteGroupAdminPageState extends State<DeleteGroupAdminPage> {

  String group = "";
  String admin = "";

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<GroupBloc,GroupState>(
        listener: (context,state){
          if(state is DeleteGroupAdminLoading){
            setState(() {
              loading = true;
            });
          }else if(state is DeleteGroupAdminLoaded){
            setState(() {
              loading = false;
            });
            if(state.status ==true) {
              toastInfo(msg: "Group admin Deleted Successful");
              Navigator.pop(context);
            }
          }else if(state is DeleteGroupAdminError){
            setState(() {
              loading = false;
            });
            toastInfo(msg: state.failure.message);
          }
        },
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.blue.shade900.withOpacity(0.8),
              resizeToAvoidBottomInset: false,
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
                        const SizedBox(height: 65),
                        //card and footer ui
                        Center(
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
                                            //richText("Show a Parish", 20),

                                            //email & password textField
                                            Stack(
                                              children: [

                                                buildInputFields(
                                                    size,
                                                    false,
                                                    "",
                                                    "Enter the group Id",
                                                    false,
                                                        (value) {
                                                      group = value;
                                                    }),
                                              ],
                                            ),
                                            const SizedBox(height: 8,),
                                            Stack(
                                              children: [

                                                buildInputFields(
                                                    size,
                                                    false,
                                                    "",
                                                    "Enter the Admin Id",
                                                    false,
                                                        (value) {
                                                      admin = value;
                                                    }),
                                              ],
                                            ),

                                            SizedBox(
                                              height: size.height * 0.05,
                                            ),

                                            //sign in button
                                            Visibility(
                                              visible: true,
                                              child: GestureDetector(
                                                onTap: () {
                                                  deleteGroupAdmin();
                                                },
                                                child: Stack(
                                                  children: [
                                                    triggerActionButtonBlue(
                                                        size, "Delete"),
                                                    Positioned(
                                                      bottom: 15,
                                                      left: 90,
                                                      child: Visibility(
                                                        visible: loading,
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
                                ]))
                      ])))),
        ));
  }

  void deleteGroupAdmin(){
    BlocProvider.of<GroupBloc>(context).add(DeleteGroupAdminEvent(int.parse(widget.parishId!), int.parse(group), int.parse(admin)));
  }
  }


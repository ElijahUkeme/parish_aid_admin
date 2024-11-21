import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_bloc.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_event.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_state.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class CreateGroupAdminPage extends StatefulWidget {
  const CreateGroupAdminPage({Key? key,this.parishId}) : super(key: key);

  final String? parishId;

  @override
  State<CreateGroupAdminPage> createState() => _CreateGroupAdminPageState();
}

class _CreateGroupAdminPageState extends State<CreateGroupAdminPage> {

   String name = "";
   String email = "";
   String role = "";
   String group = "";

  bool loading = false;
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return BlocListener<GroupBloc,GroupState>(
        listener: (context,state){
          if(state is CreateGroupAdminLoading){
            setState(() {
              loading = true;
            });
          }else if(state is CreateGroupAdminLoaded){
            setState(() {
              loading = false;
            });
            toastInfo(msg: state.adminModel.response!.message!);
            Navigator.pop(context);
          }else if(state is CreateGroupAdminError){
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
                                                    "Enter the email",
                                                    false,
                                                        (value) {
                                                      email = value;
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
                                                    "Enter the Name",
                                                    false,
                                                        (value) {
                                                      name = value;
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
                                                    "Enter the Role",
                                                    false,
                                                        (value) {
                                                      role = value;
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
                                                    "Enter the group Id",
                                                    false,
                                                        (value) {
                                                      group = value;
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
                                                  createGroupAdmin();
                                                },
                                                child: Stack(
                                                  children: [
                                                    triggerActionButtonBlue(
                                                        size, "Create"),
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

  void createGroupAdmin(){
    BlocProvider.of<GroupBloc>(context).add(CreateGroupAdminEvent(int.parse(group), int.parse(widget.parishId!),
        email, name, role));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/core/widgets/custom_top_snackbar.dart';
import 'package:parish_aid_admin/features/group/app/bloc/group_event.dart';
import 'package:parish_aid_admin/features/group/data/model/group_model.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../bloc/group_bloc.dart';
import '../bloc/group_state.dart';

class DeleteGroupPage extends StatefulWidget {
  const DeleteGroupPage({Key? key,required this.groupData}) : super(key: key);

  final GroupData groupData;

  @override
  State<DeleteGroupPage> createState() => _DeleteGroupPageState();
}

class _DeleteGroupPageState extends State<DeleteGroupPage> {

  String parishId = "";
  bool deleteGroupLoading = false;
  bool deleteGroupError = false;

  String errorText = "";

  @override
  void initState() {
    pp('Sent group Id for deleting is ${widget.groupData.id!}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<GroupBloc,GroupState>(listener: (context,state){
      pp(state.runtimeType);
      if(state is DeleteGroupLoading){
        setState(() {
          deleteGroupLoading = true;
          deleteGroupError = false;
          errorText = '';
        });
      }else if(state is DeleteGroupLoaded) {
        setState(() {
          deleteGroupLoading = false;
          deleteGroupError = false;
          errorText = "";
          if(context.mounted){
            Future.delayed(const Duration(seconds: 1)).then((value) => {
              Navigator.pop(context)
            });
          }
        });

      }else if(state is DeleteGroupError){
        setState(() {
          deleteGroupLoading = false;
          deleteGroupError = true;
          errorText = state.failure.message;
          showCustomTopSnackBar(context, message: state.failure.message);
        });
      }
    },
    child: Scaffold(
        backgroundColor: Colors.blue.shade900.withOpacity(0.8),
        //resizeToAvoidBottomInset: false,
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
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        //logo & text
                                        logo(size.height / 10, size.height / 6),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),

                                        const SizedBox(height: 16,),
                                        buildInputFields(size, false, "", "Enter the parish Id", false, (value) {
                                          parishId = value;
                                        }),
                                        SizedBox(
                                          height: size.height * 0.08,
                                        ),

                                        //sign in button
                                        Visibility(
                                          visible: true,
                                          child: GestureDetector(
                                            onTap: () {
                                              deleteGroup();
                                            },
                                            child: Stack(
                                              children: [
                                                triggerActionButtonBlue(
                                                    size, "Proceed"),
                                                Positioned(
                                                  bottom: 15,
                                                  left: 90,
                                                  child: Visibility(
                                                    visible: deleteGroupLoading,
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
                  ]))),
        )));
  }

  void deleteGroup() {
    if(parishId.isEmptyOrNull){
      showCustomTopSnackBar(context, message: 'Parish Id required');
    }
    BlocProvider.of<GroupBloc>(context).add(DeleteGroupEvent(groupId: widget.groupData.id.toString(), parishId: parishId));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/widgets/general_widgets.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_bloc.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_event.dart';
import 'package:parish_aid_admin/features/parishioner/app/bloc/parishioner_state.dart';
import 'package:parish_aid_admin/widgets/auth/auth_widgets.dart';

import '../../../../core/utils/urls.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class DeleteParishionerPage extends StatefulWidget {
  const DeleteParishionerPage({Key? key}) : super(key: key);

  @override
  State<DeleteParishionerPage> createState() => _DeleteParishionerPageState();
}

class _DeleteParishionerPageState extends State<DeleteParishionerPage> {

  bool deleteParishionerLoading = false;
  bool deleteParishionerError = false;
  String parishioner = "";
  String parish = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<ParishionerBloc,ParishionerState>(
        listener: (context,state){
      if(state is DeleteParishionerLoading){
        setState(() {
          deleteParishionerLoading = true;
          deleteParishionerError = false;
        });
      }else if(state is DeleteParishionerLoaded){
        setState(() {
          deleteParishionerLoading = false;
          deleteParishionerError = false;
        });
        toastInfo(msg: state.status.toString());
      }else if(state is DeleteParishionerError){
        setState(() {
          deleteParishionerError = true;
          deleteParishionerLoading = false;
        });
        toastInfo(msg: state.failure.message);
      }
    },
    child: SafeArea(
      child: Scaffold(
        appBar: appBar(''),
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
                                                "Enter the Parish Id",
                                                false,
                                                    (value) {
                                                  parish = value;
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
                                                "Enter the Parish Id",
                                                false,
                                                    (value) {
                                                  parish = value;
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
                                              deleteParishioner();
                                            },
                                            child: Stack(
                                              children: [
                                                triggerActionButtonBlue(
                                                    size, "Delete"),
                                                Positioned(
                                                  bottom: 15,
                                                  left: 90,
                                                  child: Visibility(
                                                    visible: deleteParishionerLoading,
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

  void deleteParishioner(){
    BlocProvider.of<ParishionerBloc>(context).add(DeleteParishionerEvent(parish, parishioner));
  }
}

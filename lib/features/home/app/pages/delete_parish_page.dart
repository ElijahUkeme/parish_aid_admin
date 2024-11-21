import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/utils/urls.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';

import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class DeleteParishPage extends StatefulWidget {
  const DeleteParishPage({Key? key}) : super(key: key);

  @override
  State<DeleteParishPage> createState() => _DeleteParishPageState();
}

class _DeleteParishPageState extends State<DeleteParishPage> {

  String parishId = "";
  bool deleteParishLoading = false;
  bool deleteParishError = false;

  String errorText = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc,HomeState>(builder: (context,state){

      if (state is DeleteParishLoading) {
        deleteParishLoading = true;
        deleteParishError = false;
        errorText = "";
      } else if (state is DeleteParishLoaded) {
        deleteParishLoading = false;
        deleteParishError = false;
        errorText = "";
        toastInfo(msg: state.status.toString());
        if (context.mounted) {
          Future.delayed(const Duration(seconds: 1)).then((value) => {
            Navigator.pop(context)
          });
        }
      } else if (state is DeleteParishError) {
        deleteParishError = false;
        deleteParishLoading = true;
        errorText = state.failure.message;
        toastInfo(msg: errorText);
      }
      return SafeArea(
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
                                                  "Enter the Parish Id",
                                                  false,
                                                      (value) {
                                                    parishId = value;
                                                  }),
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.height * 0.08,
                                          ),

                                          //sign in button
                                          Visibility(
                                            visible: true,
                                            child: GestureDetector(
                                              onTap: () {
                                                deleteParish();
                                              },
                                              child: Stack(
                                                children: [
                                                  triggerActionButtonBlue(
                                                      size, "Delete"),
                                                  Positioned(
                                                    bottom: 15,
                                                    left: 90,
                                                    child: Visibility(
                                                      visible: deleteParishLoading,
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
      );
    });
  }
  void deleteParish() {
    if(parishId.isEmpty || parishId.toString()==null){
      toastInfo(msg: "Please Enter the parish Id");
    }
    BlocProvider.of<HomeBloc>(context).add(DeleteParishEvent(parish: parishId));
  }
}

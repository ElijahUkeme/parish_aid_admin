import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class ApproveParishPage extends StatefulWidget {
  const ApproveParishPage({Key? key}) : super(key: key);

  @override
  State<ApproveParishPage> createState() => _ApproveParishPageState();
}

class _ApproveParishPageState extends State<ApproveParishPage> {

  String parishId = "";
  bool approveParishLoading = false;
  bool approveParishError = false;

  String errorText = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<HomeBloc,HomeState>(
        listener: (context,state){

      if (state is ApproveParishLoading) {
        setState(() {
          approveParishLoading = true;
          approveParishError = false;
          errorText = "";
        });
      } else if (state is ApproveParishLoaded) {
        setState(() {
          approveParishLoading = false;
          approveParishError = false;
          errorText = "";
        });
        toastInfo(msg: state.parishModel.response!.message!);
        if (context.mounted) {
          Future.delayed(const Duration(seconds: 1)).then((value) => {
            Navigator.pop(context)
          });
        }
      } else if (state is ApproveParishError) {
        setState(() {
          approveParishLoading = false;
          approveParishError = true;
          errorText = state.failure.message;
          toastInfo(msg: errorText);
        });
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
                                              approveParish();
                                            },
                                            child: Stack(
                                              children: [
                                                triggerActionButtonBlue(
                                                    size, "Proceed"),
                                                Positioned(
                                                  bottom: 15,
                                                  left: 90,
                                                  child: Visibility(
                                                    visible: approveParishLoading,
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

  void approveParish() {
    if(parishId.isEmpty || parishId.toString()==null){
      toastInfo(msg: "Please Enter the parish Id");
    }
    BlocProvider.of<HomeBloc>(context).add(ApproveParishEvent(parish: parishId));
  }
}

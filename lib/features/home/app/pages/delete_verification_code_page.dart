import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/core/widgets/custom_top_snackbar.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class DeleteVerificationCodePage extends StatefulWidget {
  const DeleteVerificationCodePage({Key? key,this.parishId}) : super(key: key);

  final String? parishId;

  @override
  State<DeleteVerificationCodePage> createState() => _DeleteVerificationCodePageState();
}

class _DeleteVerificationCodePageState extends State<DeleteVerificationCodePage> {
  bool loading = false;
  int? code;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<HomeBloc,HomeState>(listener: (context,state){
      if(state is DeleteVerificationCodeLoading){
        setState(() {
          loading = true;
        });

      }else if(state is DeleteVerificationCodeLoaded) {
        setState(() {
          loading = false;

          if(context.mounted){
            toastInfo(msg: 'Deletion Successful');
            Future.delayed(const Duration(seconds: 1)).then((value) => {
              Navigator.pop(context)
            });
          }
        });
      }else if(state is DeleteVerificationCodeError){
        setState(() {
          loading = false;
          toastInfo(msg: state.failure.message);
          Navigator.pop(context);
        });
      }
    },
      child: SafeArea(
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
                                      height: size.height * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25.0),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            //logo & text
                                            logo(size.height / 10, size.height / 6),
                                            buildInputFields(size, false, "", "Enter the verification code Id", false, (value) {
                                              code = int.parse(value);
                                            }),
                                            SizedBox(
                                              height: size.height * 0.08,
                                            ),

                                            //sign in button
                                            Visibility(
                                              visible: true,
                                              child: GestureDetector(
                                                onTap: () {
                                                  deleteVCode();
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
                                ]),
                          ))
                    ])))),
      ),
    );
  }

  void deleteVCode(){
    if(widget.parishId.isEmptyOrNull){
      showCustomTopSnackBar(context, message: 'Oops, Parish Id was not pass');
    }else if(code ==null){
      showCustomTopSnackBar(context, message: 'Please enter the verification code id');
    }else{
      BlocProvider.of<HomeBloc>(context).add(DeleteVerificationCodeEvent(int.parse(widget.parishId!), code!));
    }
  }
}

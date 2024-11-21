

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';

import '../../../../core/utils/urls.dart';
import '../../../../core/widgets/custom_date_picker.dart';
import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class UpdateVerificationCodePage extends StatefulWidget {
  const UpdateVerificationCodePage({Key? key,this.parishId}) : super(key: key);
  final String? parishId;

  @override
  State<UpdateVerificationCodePage> createState() => _UpdateVerificationCodePageState();
}

class _UpdateVerificationCodePageState extends State<UpdateVerificationCodePage> {

  int? vCode;
  int? printStatus;
  String? status;
  String? expiresAt;

  bool loading = false;
  VerificationCodeModel? model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is UpdateVerificationCodeLoading) {
        setState(() {
          loading = true;
        });
      } else if (state is UpdateVerificationCodeLoaded) {
        setState(() {
          loading = false;
          model = state.model;
          if (context.mounted) {
            if (model != null) {
              showCustomTopSnackBar(context,
                  message: state.model.response!.message!);
              // Future.delayed(const Duration(seconds: 1)).then((value) => {
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>
              //       GetBillingPlansDetailsPage(model: model!)))
              // });
            }
          }
        });
      } else if (state is UpdateVerificationCodeError) {
        loading = false;
        toastInfo(msg: state.failure.message);
      }
      return SafeArea(
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
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          CustomDatePicker(
                                              onSelected: (value) {
                                                expiresAt = value;
                                              },
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2025)),
                                          SizedBox(
                                            height: size.height * 0.08,
                                          ),

                                          buildInputFields(size, false, "",
                                              "Enter the Verification Code", false, (value) {
                                                vCode = int.parse(value);
                                              }),
                                          SizedBox(
                                            height: size.height * 0.08,
                                          ),
                                          buildInputFields(size, false, "",
                                              "Enter the printing status", false, (value) {
                                                printStatus = int.parse(value);
                                              }),
                                          SizedBox(
                                            height: size.height * 0.08,
                                          ),

                                          buildInputFields(size, false, "",
                                              "Enter the Status", false, (value) {
                                                status = value;
                                              }),
                                          SizedBox(
                                            height: size.height * 0.08,
                                          ),

                                          //sign in button
                                          Visibility(
                                            visible: true,
                                            child: GestureDetector(
                                              onTap: () {
                                                updateVerificationCode();
                                              },
                                              child: Stack(
                                                children: [
                                                  triggerActionButtonBlue(
                                                      size, "Update"),
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
      );
    });
  }

  void updateVerificationCode(){
    if(widget.parishId!.isEmpty || widget.parishId ==null){
      showCustomTopSnackBar(context, message: "Parish Id was not passed, please go back and try again");
    }else if(vCode==null){
      showCustomTopSnackBar(context, message: "Verification code required");
    }else{
      BlocProvider.of<HomeBloc>(context).add(UpdateVerificationCodeEvent(int.parse(widget.parishId!), vCode!, printStatus, status, expiresAt));
    }
  }
}

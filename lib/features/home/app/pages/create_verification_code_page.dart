import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/core/widgets/custom_date_picker.dart';
import 'package:parish_aid_admin/core/widgets/custom_top_snackbar.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_state.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class CreateVerificationCodePage extends StatefulWidget {
  const CreateVerificationCodePage({Key? key, this.parishId}) : super(key: key);
  final String? parishId;

  @override
  State<CreateVerificationCodePage> createState() =>
      _CreateVerificationCodePageState();
}

class _CreateVerificationCodePageState
    extends State<CreateVerificationCodePage> {
  String? expiresAt;
  int? quantity;
  bool loading = false;
  String expirationTxt = 'Select expiration date';

  VerificationCodeModel? model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<HomeBloc, HomeState>(listener: (context, state) {
      if (state is CreateVerificationCodeLoading) {
        setState(() {
          loading = true;
        });
      } else if (state is CreateVerificationCodeLoaded) {
        setState(() {
          loading = false;
          model = state.model;
          if (context.mounted) {
            if (model != null) {
              showCustomTopSnackBar(context,
                  message: 'Verification code created Successfully');
              Navigator.pop(context);
            }
          }
        });
      } else if (state is CreateVerificationCodeError) {
        setState(() {
          loading = false;
          toastInfo(msg: state.failure.message);
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

                                            //padding: EdgeInsets.all(12),
                                            CustomDatePicker(
                                              //hintText: "Select Expiration date",
                                                text: expirationTxt,
                                                onSelected: (value) {
                                                  setState(() {
                                                    expirationTxt = value;
                                                    expiresAt = value;
                                                  });
                                                },
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2025)),

                                            SizedBox(
                                              height: size.height * 0.001,
                                            ),

                                            buildInputFields(size*1.2, false, "",
                                                "Enter the quantity", false, (value) {
                                                  quantity = int.parse(value);
                                                }),
                                            SizedBox(
                                              height: size.height * 0.08,
                                            ),

                                            //sign in button
                                            Visibility(
                                              visible: true,
                                              child: GestureDetector(
                                                onTap: () {
                                                  createVerificationCode();
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
                                ]),
                          ))
                    ])))),
      ),
    );
  }

  void createVerificationCode(){
    if(widget.parishId ==null || widget.parishId!.isEmpty){
      showCustomTopSnackBar(context, message: 'Parish Id was not passed');
    }else if(quantity ==null || quantity ==0){
      showCustomTopSnackBar(context, message: "Quantity must be at least 1");
    }else if(expiresAt == null || expiresAt!.isEmpty){
      showCustomTopSnackBar(context, message: "Please select expiration period");
    }else{
      BlocProvider.of<HomeBloc>(context).add(CreateVerificationCodeEvent(parishId: int.parse(widget.parishId!),
          quantity: quantity!, expiresAt: expiresAt!));
    }
  }
}

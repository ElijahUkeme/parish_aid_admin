import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/home/app/bloc/home_event.dart';
import 'package:parish_aid_admin/features/home/app/pages/verification_code_details_page.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class ShowVerificationCodePage extends StatefulWidget {
  const ShowVerificationCodePage({Key? key, this.parishId}) : super(key: key);

  final String? parishId;

  @override
  State<ShowVerificationCodePage> createState() =>
      _ShowVerificationCodePageState();
}

class _ShowVerificationCodePageState extends State<ShowVerificationCodePage> {
  String code = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is ShowVerificationCodeLoading) {
          setState(() {
            loading = true;
          });
        } else if (state is ShowVerificationCodeLoaded) {
          setState(() {
            loading = false;
            if(state.data !=null){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>VerificationCodeDetailsPage(data: state.data)));
            }
          });
        } else if (state is ShowVerificationCodeError) {
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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: 40,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            //resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: SizedBox(
                    height: size.height,
                    child:
                        Stack(alignment: Alignment.center, children: <Widget>[
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //logo & text
                                        logo(size.height / 10, size.height / 6),
                                        buildInputFields(
                                            size,
                                            false,
                                            "",
                                            "Enter the verification code Id",
                                            false, (value) {
                                          code = value;
                                        }),
                                        SizedBox(
                                          height: size.height * 0.08,
                                        ),

                                        //sign in button
                                        Visibility(
                                          visible: true,
                                          child: GestureDetector(
                                            onTap: () {
                                              showVerificationCode();
                                            },
                                            child: Stack(
                                              children: [
                                                triggerActionButtonBlue(
                                                    size, "Show"),
                                                Positioned(
                                                  bottom: 15,
                                                  left: 90,
                                                  child: Visibility(
                                                    visible: loading,
                                                    child:
                                                        buildLoadingIndicator(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.8)),
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

  void showVerificationCode() {
    BlocProvider.of<HomeBloc>(context).add(ShowVerificationCodeEvent(
        int.parse(widget.parishId!), int.parse(code)));
  }
}

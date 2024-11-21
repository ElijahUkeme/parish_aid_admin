import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/widgets/custom_top_snackbar.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_bloc.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_event.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_state.dart';
import 'package:parish_aid_admin/features/billing/app/pages/get_subscription_details_page.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class InitiateBillingSubscriptionPage extends StatefulWidget {
  const InitiateBillingSubscriptionPage({Key? key,this.parishId}) : super(key: key);

  final String? parishId;

  @override
  State<InitiateBillingSubscriptionPage> createState() => _InitiateBillingSubscriptionPageState();
}

class _InitiateBillingSubscriptionPageState extends State<InitiateBillingSubscriptionPage> {

  int? planId;
  String? method;
  String? gateway;
  bool loading = false;

  SubscriptionModel? model;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<BillingPlansBloc,BillingPlansState>(
        listener: (context,state){
          if(state is InitiateSubscriptionLoading){
            setState(() {
              loading = true;
            });
          }else if(state is InitiateSubscriptionLoaded){
            setState(() {
              loading = false;
            });
            if(state.model !=null) {
              toastInfo(msg: "Initialization Successful");
              if (context.mounted) {
                Future.delayed(const Duration(seconds: 1)).then((value) =>
                {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          GetSubscriptionDetailsPage(model: model!)))
                });
              }
            }
          }else if(state is InitiateSubscriptionError){
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
                                                    "Enter the plan Id",
                                                    false,
                                                        (value) {
                                                      planId = int.parse(value);
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
                                                    "Enter the method",
                                                    false,
                                                        (value) {
                                                      method = value;
                                                    }),
                                              ],
                                            ),

                                            Stack(
                                              children: [

                                                buildInputFields(
                                                    size,
                                                    false,
                                                    "",
                                                    "Enter the plan Gateway",
                                                    false,
                                                        (value) {
                                                      gateway = value;
                                                    }),
                                              ],
                                            ),
                                            const SizedBox(height: 8,),

                                            SizedBox(
                                              height: size.height * 0.05,
                                            ),

                                            //sign in button
                                            Visibility(
                                              visible: true,
                                              child: GestureDetector(
                                                onTap: () {
                                                  initiateBillingSubscription();
                                                },
                                                child: Stack(
                                                  children: [
                                                    triggerActionButtonBlue(
                                                        size, "Initiate"),
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

  void initiateBillingSubscription(){
    if(planId ==null){
      showCustomTopSnackBar(context, message: "please enter plan Id");
    }else if(widget.parishId!.isEmpty){
      showCustomTopSnackBar(context, message: "Parish Id was not passed");
    }else if(method!.isEmpty){
      showCustomTopSnackBar(context, message: "Method is required");
    }else if(gateway!.isEmpty){
      showCustomTopSnackBar(context, message: "Gateway required");
    }else{
      BlocProvider.of<BillingPlansBloc>(context).add(InitiateSubscriptionEvent(int.parse(widget.parishId!), planId!, method!, gateway!));
    }
  }
}

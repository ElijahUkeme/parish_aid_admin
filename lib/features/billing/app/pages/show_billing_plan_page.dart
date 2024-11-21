import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/core/utils/urls.dart';
import 'package:parish_aid_admin/core/widgets/general_widgets.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_bloc.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_event.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_state.dart';
import 'package:parish_aid_admin/features/billing/app/pages/get_billing_plans_details_page.dart';
import 'package:parish_aid_admin/features/billing/data/models/billing_plans_model.dart';

import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';

class ShowBillingPlanPage extends StatefulWidget {
  const ShowBillingPlanPage({Key? key,this.parishId}) : super(key: key);
  final String? parishId;

  @override
  State<ShowBillingPlanPage> createState() => _ShowBillingPlanPageState();
}

class _ShowBillingPlanPageState extends State<ShowBillingPlanPage> {
  String planId = "";
  bool loading = false;
  BillingPlansModel? model;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<BillingPlansBloc,BillingPlansState>(listener: (context,state){
      pp(state.runtimeType);
      if(state is ShowBillingPlansLoading){
          setState(() {
            loading = true;
          });
      }else if(state is ShowBillingPlansLoaded) {
         setState(() {
           loading = false;
           model = state.model;
           if(context.mounted){
             if(model !=null){
               Future.delayed(const Duration(seconds: 1)).then((value) => {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>
                     GetBillingPlansDetailsPage(model: model!)))
               });
             }
           }
         });

      }else if(state is ShowBillingPlansError){
        setState(() {
          loading = false;
          toastInfo(msg: state.failure.message);
        });
      }
    },
      child: Scaffold(
          backgroundColor: Colors.blue.shade900.withOpacity(0.8),
          appBar: appBar(''),
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
                                          logo(size.height / 10, size.height / 6),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),

                                          const SizedBox(height: 16,),
                                          buildInputFields(size, false, "", "Enter the plan Id", false, (value) {
                                            planId = value;
                                          }),
                                          SizedBox(
                                            height: size.height * 0.08,
                                          ),

                                          //sign in button
                                          Visibility(
                                            visible: true,
                                            child: GestureDetector(
                                              onTap: () {
                                                showBillingPlans();
                                              },
                                              child: Stack(
                                                children: [
                                                  triggerActionButtonBlue(
                                                      size, "Proceed"),
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
    );
  }

  void  showBillingPlans(){
    BlocProvider.of<BillingPlansBloc>(context).add(ShowBillingPlansEvent(int.parse(planId), int.parse(widget.parishId!)));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_event.dart';
import 'package:parish_aid_admin/features/billing/app/pages/get_subscription_details_page.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';

import '../../../../core/utils/urls.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../../auth/app/widgets/auth_page_widgets.dart';
import '../bloc/billing_plans_bloc.dart';
import '../bloc/billing_plans_state.dart';

class ShowSubscriptionPage extends StatefulWidget {
  const ShowSubscriptionPage({Key? key,this.parishId}) : super(key: key);
  final String? parishId;

  @override
  State<ShowSubscriptionPage> createState() => _ShowSubscriptionPageState();
}

class _ShowSubscriptionPageState extends State<ShowSubscriptionPage> {

  String subscription = "";
  bool loading = false;
  SubscriptionModel? model;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<BillingPlansBloc,BillingPlansState>(listener: (context,state){
      if(state is ShowSubscriptionLoading){
          setState(() {
            loading = true;
          });
      }else if(state is ShowSubscriptionLoaded) {
          setState(() {
            loading = false;
            model = state.model;
            if(context.mounted){
              if(model !=null){
                Future.delayed(const Duration(seconds: 1)).then((value) => {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      GetSubscriptionDetailsPage(model: model!)))
                });
              }
            }
          });
      }else if(state is ShowSubscriptionError){
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
                    //const SizedBox(height: 65),
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
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          //logo & text
                                          logo(size.height / 10, size.height / 6),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),

                                          const SizedBox(height: 16,),
                                          buildInputFields(size, false, "", "Enter the subscription Id", false, (value) {
                                            subscription = value;
                                          }),
                                          SizedBox(
                                            height: size.height * 0.08,
                                          ),

                                          //sign in button
                                          Visibility(
                                            visible: true,
                                            child: GestureDetector(
                                              onTap: () {
                                                showSubscriptionPlan();
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
    ));
  }

  void showSubscriptionPlan(){
    BlocProvider.of<BillingPlansBloc>(context).add(ShowSubscriptionEvent(int.parse(widget.parishId!), int.parse(subscription)));
  }
}

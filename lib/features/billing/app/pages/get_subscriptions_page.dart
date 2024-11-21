import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_event.dart';
import 'package:parish_aid_admin/features/billing/app/widget/subscription_card_data.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';

import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../bloc/billing_plans_bloc.dart';
import '../bloc/billing_plans_state.dart';

class GetSubscriptionsPage extends StatefulWidget {
  const GetSubscriptionsPage({Key? key,this.parishId}) : super(key: key);

  final String? parishId;

  @override
  State<GetSubscriptionsPage> createState() => _GetSubscriptionsPageState();
}

class _GetSubscriptionsPageState extends State<GetSubscriptionsPage> {

  List<SubscriptionModel>? model;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getSubscriptionPlansList();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingPlansBloc,BillingPlansState>(builder: (context,state){
      if(state is GetSubscriptionsLoading){

          loading = true;
      }else if(state is GetSubscriptionsLoaded){
        model = state.model;
        loading = false;
        if(model!.isEmpty){
          Future.delayed(Duration.zero).then((value) => {
            if (context.mounted)
              {
                toastInfo(msg: "The list is empty"),
                Navigator.pop(context)
              }
          });
        }
      }else if(state is GetSubscriptionsError){
        loading = false;
        Future.delayed(const Duration(seconds: 1)).then((value) => {
          if (context.mounted)
            {
              Navigator.pop(context),
              showCustomTopSnackBar(context,
                  message: state.failure.message, color: Colors.red)
            }
        });
      }
      return loading
          ? Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue.shade900.withOpacity(0.8),
          ),
        ),
      )
          : Scaffold(
        appBar: appBar(),
        body: body(),
      );
    });
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: const IconThemeData(
          color: Colors.white
      ),
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
    );
  }
  Widget body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [subscriptionData()],
      ),
    );
  }

  Widget subscriptionData() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: model!.length,
      itemBuilder: (BuildContext context, int index) {
        return SubscriptionCardData(model: model![index]);
      },
    );
  }

  void getSubscriptionPlansList(){
    BlocProvider.of<BillingPlansBloc>(context).add(GetSubscriptionsEvent(int.parse(widget.parishId!)));
  }
}

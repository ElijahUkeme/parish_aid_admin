import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/widgets/general_widgets.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_bloc.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_event.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_state.dart';
import 'package:parish_aid_admin/features/billing/app/widget/billing_plans_card.dart';
import 'package:parish_aid_admin/features/billing/data/models/billing_plans_model.dart';

import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../widgets/auth/auth_widgets.dart';

class GetBillingPlansPage extends StatefulWidget {
  const GetBillingPlansPage({Key? key,this.parishId}) : super(key: key);
  final String? parishId;

  @override
  State<GetBillingPlansPage> createState() => _GetBillingPlansPageState();
}

class _GetBillingPlansPageState extends State<GetBillingPlansPage> {

  List<BillingPlansModel>? model;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getBillingPlansList();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingPlansBloc,BillingPlansState>(builder: (context,state){
      if(state is GetBillingPlansLoading){
          loading = true;

      }else if(state is GetBillingPlansLoaded){
        model = state.model;
        loading = false;
        if(model!.isEmpty){
          Navigator.pop(context);
          toastInfo(msg: "The list is empty");
        }
      }else if(state is GetBillingPlansError){
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
        appBar: appBar(''),
        body: body(),
      );
    });
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [billingData()],
      ),
    );
  }

  Widget billingData() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: model!.length,
      itemBuilder: (BuildContext context, int index) {
        return BillingPlansCard(billings: model![index]);
      },
    );
  }

  void getBillingPlansList(){
    BlocProvider.of<BillingPlansBloc>(context).add(GetBillingPlansEvent(int.parse(widget.parishId!)));
  }

}

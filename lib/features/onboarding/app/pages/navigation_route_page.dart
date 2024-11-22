import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/billing/app/pages/get_billing_plans_page.dart';
import 'package:parish_aid_admin/features/billing/app/pages/get_subscriptions_page.dart';
import 'package:parish_aid_admin/features/billing/app/pages/initiate_billing_subscription_page.dart';
import 'package:parish_aid_admin/features/billing/app/pages/show_billing_plan_page.dart';
import 'package:parish_aid_admin/features/billing/app/pages/show_subscription_page.dart';
import 'package:parish_aid_admin/features/group/app/page/Verify_group_admin_list_page.dart';
import 'package:parish_aid_admin/features/group/app/page/delete_group_page.dart';
import 'package:parish_aid_admin/features/group/app/page/get_group_page.dart';
import 'package:parish_aid_admin/features/group/app/page/show_all_group_admin_page.dart';
import 'package:parish_aid_admin/features/group/app/page/show_all_group_page.dart';
import 'package:parish_aid_admin/features/group/app/page/update_group_page.dart';
import 'package:parish_aid_admin/features/home/app/pages/approve_parish_page.dart';
import 'package:parish_aid_admin/features/home/app/pages/create_verification_code_page.dart';
import 'package:parish_aid_admin/features/home/app/pages/delete_parish_page.dart';
import 'package:parish_aid_admin/features/home/app/pages/delete_verification_code_page.dart';
import 'package:parish_aid_admin/features/home/app/pages/get_verification_code_stat_page.dart';
import 'package:parish_aid_admin/features/home/app/pages/show_a_parish_page.dart';
import 'package:parish_aid_admin/features/home/app/pages/show_all_parish_page.dart';
import 'package:parish_aid_admin/features/home/app/pages/show_all_verification_code_page.dart';
import 'package:parish_aid_admin/features/home/app/pages/show_verification_code_page.dart';
import 'package:parish_aid_admin/features/home/app/pages/update_parish_page.dart';
import 'package:parish_aid_admin/features/parishioner/app/page/create_parishioner_page.dart';
import 'package:parish_aid_admin/features/parishioner/app/page/delete_parishioner_page.dart';
import 'package:parish_aid_admin/features/parishioner/app/page/get_parishioner_page.dart';
import 'package:parish_aid_admin/features/parishioner/app/page/show_all_parishioners_page.dart';
import 'package:parish_aid_admin/features/transaction/app/bloc/transaction_bloc.dart';
import 'package:parish_aid_admin/features/transaction/app/pages/get_transactions_page.dart';
import 'package:parish_aid_admin/features/users/data/models/user_account_fetch_model.dart';

import '../../../../injection_container.dart';
import '../../../group/app/page/create_group_page.dart';
import '../../../home/app/pages/create_parish_page.dart';

void navigate(BuildContext context, String action, Parish? parish) {
  if (action.toString() == "Create a Parish") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateParishPage(),
      ),
    );
  } else if (action.toString() == "Create a Group") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateGroupPage(parishId: parish!.id.toString()),
      ),
    );
  } else if (action.toString() == "Show All Parish") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ShowAllParishPage(),
      ),
    );
  } else if (action.toString() == "Show a Parish") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>  ShowAParishPage(parishId: parish!.id.toString()),
      ),
    );
  } else if (action.toString() == "Update a Parish") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateParishPage(parish: parish!),
      ),
    );
  } else if (action.toString() == "Approve a Parish") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ApproveParishPage(),
      ),
    );
  } else if (action.toString() == "Delete a Parish") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DeleteParishPage(),
      ),
    );
  } else if (action.toString() == "Show a Group") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GetGroupPage(parishId: parish!.id.toString()),
      ),
    );
  } else if (action.toString() == "Get all Groups") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShowAllGroupPage(parishId: parish!.id.toString()),
      ),
    );
  } else if (action.toString() == "Create a Parishioner") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateParishionerPage(),
      ),
    );
  } else if (action.toString() == "Update a Parishioner") {
    //Navigator.of(context).push(
    //MaterialPageRoute(
    //builder: (context) => const CreateParishioUpnerPage(),
    //),
    //);
  } else if (action.toString() == "Get all Parishioners") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ShowAllParishionersPage(parishId: parish!.id.toString()),
      ),
    );
  } else if (action.toString() == "Show a Parishioner") {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              GetParishionerPage(parishId: parish!.id.toString())),
    );
  } else if (action.toString() == "Delete a Parishioner") {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DeleteParishionerPage(),
      ),
    );
  }else if(action.toString()=="Show All Billings"){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>GetBillingPlansPage(parishId: parish!.id.toString())));
  }else if(action.toString()=="Get Subscription List"){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>GetSubscriptionsPage(parishId: parish!.id.toString()))
    );
  }else if(action.toString()=="Initiate Subscription"){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>InitiateBillingSubscriptionPage(parishId: parish!.id.toString()))
    );
  }else if(action.toString() == "Show a Billing"){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>ShowBillingPlanPage(parishId: parish!.id.toString()))
    );
  }else if(action.toString()=="Show a Subscription"){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>ShowSubscriptionPage(parishId: parish!.id.toString()))
    );
  }else if(action.toString() == "Create a Verification Code"){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>CreateVerificationCodePage(parishId: parish!.id.toString()))
    );
  }else if(action.toString()=="Get all Verification Code"){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>ShowAllVerificationCodePage(parishId: parish!.id.toString()))
    );
  }else if(action.toString()=="Get Statistics"){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>GetVerificationCodeStatPage(parishId: parish!.id.toString()))
    );
  }else if(action.toString()=="Delete a Verification Code"){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>DeleteVerificationCodePage(parishId: parish!.id.toString()))
    );
  }else if(action.toString()== "Show Verification Code"){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context)=>ShowVerificationCodePage(parishId: parish!.id.toString())));
  }else if(action.toString()=="Get all Group Admin"){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyGroupAdminListPage(parishId: parish!.id)));
  }else if(action.toString()=='Get Transactions'){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(
  create: (context) => sl<TransactionBloc>(),
  child: GetTransactionsPage(parishId: parish!.id),
)));
  }
}

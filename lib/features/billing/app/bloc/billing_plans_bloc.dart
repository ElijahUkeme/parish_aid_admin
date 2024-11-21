import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_event.dart';
import 'package:parish_aid_admin/features/billing/app/bloc/billing_plans_state.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/get_billing_plans.dart';

import '../../domain/usecase/get_subscriptions.dart';
import '../../domain/usecase/initiate_billing_subscription.dart';
import '../../domain/usecase/show_billing_plan.dart';
import '../../domain/usecase/show_subscription.dart';

class BillingPlansBloc extends Bloc<BillingPlansEvent,BillingPlansState>{
  final GetBillingPlans getBillingPlans;
  final ShowBillingPlan showBillingPlan;
  final GetSubscriptions getSubscription;
  final ShowSubscription showSubscription;
  final InitiateBillingSubscription initiateBillingSubscription;

  BillingPlansBloc({required this.getBillingPlans,
    required this.showBillingPlan,
   required this.getSubscription,
   required this.showSubscription,
  required this.initiateBillingSubscription}):super(BillingPlansInitial()){
    on<BillingPlansEvent>((event,emit) async {
      if(event is GetBillingPlansEvent){
        emit(GetBillingPlansLoading());

        final  result = await getBillingPlans(GetBillingPlansParam(event.parish));

        emit(result.fold((failure)=>GetBillingPlansError(failure), (model)=>GetBillingPlansLoaded(model)));
      }else if(event is ShowBillingPlansEvent){
        emit(ShowBillingPlansLoading());

        final result = await showBillingPlan(ShowBillingPlanParams(event.parish, event.plan));

        emit(result.fold((failure)=>ShowBillingPlansError(failure),
            (model)=>ShowBillingPlansLoaded(model)));
      }else if(event is GetSubscriptionsEvent){
        emit(GetSubscriptionsLoading());

        final result = await getSubscription(GetSubscriptionsParam(event.parish));

        emit(result.fold((failure)=>GetSubscriptionsError(failure),
            (model)=>GetSubscriptionsLoaded(model)));
      }else if(event is ShowSubscriptionEvent){
        emit(ShowSubscriptionLoading());

        final result = await showSubscription(ShowSubscriptionParams(event.parish, event.subscription));

        emit(result.fold((failure)=>ShowSubscriptionError(failure),
            (model)=>ShowSubscriptionLoaded(model)));
      }else if(event is InitiateSubscriptionEvent){
        emit(InitiateSubscriptionLoading());

        final result = await initiateBillingSubscription(
            InitiateBillingSubscriptionParams(event.parish, event.planId, event.method, event.gateway));
        emit(result.fold((failure)=>InitiateSubscriptionError(failure), (model)=>InitiateSubscriptionLoaded(model)));
      }
    });
  }
}
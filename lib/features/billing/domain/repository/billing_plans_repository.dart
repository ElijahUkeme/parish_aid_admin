import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/billing/data/models/billing_plans_model.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/get_billing_plans.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/get_subscriptions.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/initiate_billing_subscription.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/show_billing_plan.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/show_subscription.dart';

abstract class BillingPlansRepository{
  Future<Either<Failure,List<BillingPlansModel>>> getBillingPlans(GetBillingPlansParam param);
  Future<Either<Failure,BillingPlansModel>> showBillingPlans(ShowBillingPlanParams params);
  Future<Either<Failure,List<SubscriptionModel>>> getSubscriptions(GetSubscriptionsParam param);
  Future<Either<Failure,SubscriptionModel>> showSubscription(ShowSubscriptionParams params);
  Future<Either<Failure,SubscriptionModel>> initiateSubscription(InitiateBillingSubscriptionParams params);
}
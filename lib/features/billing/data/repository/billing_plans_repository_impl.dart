import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/billing/data/models/billing_plans_model.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';
import 'package:parish_aid_admin/features/billing/data/sources/billing_plans_remote_source.dart';
import 'package:parish_aid_admin/features/billing/domain/repository/billing_plans_repository.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/get_billing_plans.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/get_subscriptions.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/initiate_billing_subscription.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/show_billing_plan.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/show_subscription.dart';

import '../../../../core/network_info/network_info.dart';

class BillingPlansRepositoryImpl extends BillingPlansRepository{
  final NetworkInfo networkInfo;
  final BillingPlansRemoteSource billingPlansRemoteSource;

  BillingPlansRepositoryImpl({required this.billingPlansRemoteSource,required this.networkInfo});

  @override
  Future<Either<Failure, List<BillingPlansModel>>> getBillingPlans(GetBillingPlansParam param) {
   return ServiceRunner<List<BillingPlansModel>>(networkInfo: networkInfo)
       .runNetworkTask(()=>billingPlansRemoteSource.getBillingPlans(param));
  }

  @override
  Future<Either<Failure, BillingPlansModel>> showBillingPlans(ShowBillingPlanParams params) {
    return ServiceRunner<BillingPlansModel>(networkInfo: networkInfo)
        .runNetworkTask(()=>billingPlansRemoteSource.showBillingPlans(params));
  }

  @override
  Future<Either<Failure, List<SubscriptionModel>>> getSubscriptions(GetSubscriptionsParam param) {
    return ServiceRunner<List<SubscriptionModel>>(networkInfo: networkInfo)
        .runNetworkTask(()=>billingPlansRemoteSource.getSubscriptions(param));
  }

  @override
  Future<Either<Failure, SubscriptionModel>> showSubscription(ShowSubscriptionParams params) {
    return ServiceRunner<SubscriptionModel>(networkInfo: networkInfo)
        .runNetworkTask(()=>billingPlansRemoteSource.showSubscription(params));
  }

  @override
  Future<Either<Failure, SubscriptionModel>> initiateSubscription(InitiateBillingSubscriptionParams params) {
    return ServiceRunner<SubscriptionModel>(networkInfo: networkInfo)
        .runNetworkTask(()=>billingPlansRemoteSource.initiateSubscription(params));
  }
}
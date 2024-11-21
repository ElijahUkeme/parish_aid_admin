import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/billing/data/models/billing_plans_model.dart';

import '../../data/models/subscription_model.dart';

class BillingPlansState extends Equatable{

  @override
  List<Object?> get props => [];

}
class BillingPlansInitial extends BillingPlansState{}
class GetBillingPlansLoading extends BillingPlansState{}
class GetBillingPlansLoaded extends BillingPlansState{
  final List<BillingPlansModel> model;
  GetBillingPlansLoaded(this.model);
}
class GetBillingPlansError extends BillingPlansState{
  final Failure failure;
  GetBillingPlansError(this.failure);
}
class ShowBillingPlansLoading extends BillingPlansState{}
class ShowBillingPlansLoaded extends BillingPlansState{
  final BillingPlansModel model;
  ShowBillingPlansLoaded(this.model);
}
class ShowBillingPlansError extends BillingPlansState{
  final Failure failure;
  ShowBillingPlansError(this.failure);
}
class GetSubscriptionsLoading extends BillingPlansState{}
class GetSubscriptionsLoaded extends BillingPlansState{
  final List<SubscriptionModel> model;
  GetSubscriptionsLoaded(this.model);
}
class GetSubscriptionsError extends BillingPlansState{
  final Failure failure;
  GetSubscriptionsError(this.failure);
}
class ShowSubscriptionLoading extends BillingPlansState{}
class ShowSubscriptionLoaded extends BillingPlansState{
  final SubscriptionModel model;
  ShowSubscriptionLoaded(this.model);
}
class ShowSubscriptionError extends BillingPlansState{
  final Failure failure;
  ShowSubscriptionError(this.failure);
}
class InitiateSubscriptionLoading extends BillingPlansState{}
class InitiateSubscriptionLoaded extends BillingPlansState{
  final SubscriptionModel model;
  InitiateSubscriptionLoaded(this.model);
}
class InitiateSubscriptionError extends BillingPlansState{
  final Failure failure;
  InitiateSubscriptionError(this.failure);
}
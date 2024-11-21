import 'package:equatable/equatable.dart';

class BillingPlansEvent extends Equatable{
  @override
  List<Object?> get props => [];

}
class GetBillingPlansEvent extends BillingPlansEvent{
  final int parish;
  GetBillingPlansEvent(this.parish);
}
class ShowBillingPlansEvent extends BillingPlansEvent{
  final int parish;
  final int plan;

  ShowBillingPlansEvent(this.plan,this.parish);
}
class GetSubscriptionsEvent extends BillingPlansEvent{
  final int parish;
  GetSubscriptionsEvent(this.parish);
}
class ShowSubscriptionEvent extends BillingPlansEvent{
  final int parish;
  final int subscription;
  ShowSubscriptionEvent(this.parish,this.subscription);
}
class InitiateSubscriptionEvent extends BillingPlansEvent{
  final int parish;
  final int planId;
  final String method;
  final String gateway;

  InitiateSubscriptionEvent(this.parish,this.planId,this.method,this.gateway);
}
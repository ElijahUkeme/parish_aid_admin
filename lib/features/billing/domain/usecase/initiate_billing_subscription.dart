import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';
import 'package:parish_aid_admin/features/billing/domain/repository/billing_plans_repository.dart';

class InitiateBillingSubscription extends Usecase<SubscriptionModel,InitiateBillingSubscriptionParams>{
  final BillingPlansRepository billingPlansRepository;
  InitiateBillingSubscription(this.billingPlansRepository);

  @override
  Future<Either<Failure, SubscriptionModel>> call(InitiateBillingSubscriptionParams params) {
   return billingPlansRepository.initiateSubscription(params);
  }
}

class InitiateBillingSubscriptionParams extends Equatable{
  final int parish;
  final int planId;
  final String method;
  final String gateway;

  const InitiateBillingSubscriptionParams(this.parish,this.planId,this.method,this.gateway);

  @override
  List<Object?> get props => [];
}
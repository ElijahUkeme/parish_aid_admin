import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';
import 'package:parish_aid_admin/features/billing/domain/repository/billing_plans_repository.dart';

class ShowSubscription extends Usecase<SubscriptionModel,ShowSubscriptionParams>{
  final BillingPlansRepository billingPlansRepository;

  ShowSubscription(this.billingPlansRepository);

  @override
  Future<Either<Failure, SubscriptionModel>> call(ShowSubscriptionParams params) {
    return billingPlansRepository.showSubscription(params);
  }
}

class ShowSubscriptionParams extends Equatable{
  final int parish;
  final int subscription;
  const ShowSubscriptionParams(this.parish,this.subscription);

  @override
  List<Object?> get props => [];
}
import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';
import 'package:parish_aid_admin/features/billing/domain/repository/billing_plans_repository.dart';

class GetSubscriptions extends Usecase<List<SubscriptionModel>,GetSubscriptionsParam>{
  final BillingPlansRepository billingPlansRepository;

  GetSubscriptions(this.billingPlansRepository);

  @override
  Future<Either<Failure, List<SubscriptionModel>>> call(GetSubscriptionsParam param) {
    return billingPlansRepository.getSubscriptions(param);
  }
}

class GetSubscriptionsParam extends Equatable{
  final int parish;
  const GetSubscriptionsParam(this.parish);

  @override
  List<Object?> get props => [];
}
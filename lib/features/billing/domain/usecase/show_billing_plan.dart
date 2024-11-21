import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/billing/data/models/billing_plans_model.dart';
import 'package:parish_aid_admin/features/billing/domain/repository/billing_plans_repository.dart';

class ShowBillingPlan extends Usecase<BillingPlansModel,ShowBillingPlanParams>{
  final BillingPlansRepository billingPlansRepository;
  ShowBillingPlan(this.billingPlansRepository);

  @override
  Future<Either<Failure, BillingPlansModel>> call(ShowBillingPlanParams params) {
    return billingPlansRepository.showBillingPlans(params);
  }

}

class ShowBillingPlanParams extends Equatable{
  final int parish;
  final int plan;

  const ShowBillingPlanParams(this.parish,this.plan);

  @override
  List<Object?> get props => [];
}
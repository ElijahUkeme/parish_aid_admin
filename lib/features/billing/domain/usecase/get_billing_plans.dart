import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/billing/data/models/billing_plans_model.dart';
import 'package:parish_aid_admin/features/billing/domain/repository/billing_plans_repository.dart';

class GetBillingPlans extends Usecase<List<BillingPlansModel>,GetBillingPlansParam>{

  final BillingPlansRepository billingPlansRepository;
  GetBillingPlans(this.billingPlansRepository);

  @override
  Future<Either<Failure, List<BillingPlansModel>>> call( GetBillingPlansParam param) {
   return billingPlansRepository.getBillingPlans(param);
  }

}
class GetBillingPlansParam extends Equatable{
  final int parish;
  const GetBillingPlansParam(this.parish);

  @override
  List<Object?> get props => [];
}
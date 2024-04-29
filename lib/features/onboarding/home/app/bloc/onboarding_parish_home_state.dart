import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';

class OnboardingParishHomeState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnboardingParishHomeInitial extends OnboardingParishHomeState {}

class GetOnBoardingParishHomeLoading extends OnboardingParishHomeState {}

class GetOnboardingParishHomeLoaded extends OnboardingParishHomeState {
  final ParishModel parishModel;
  GetOnboardingParishHomeLoaded(this.parishModel);
}

class GetOnboardingParishHomeError extends OnboardingParishHomeState {
  final Failure failure;
  GetOnboardingParishHomeError(this.failure);
}

class GetOnboardingParishByUidLoading extends OnboardingParishHomeState {}

class GetOnboardingParishByUidLoaded extends OnboardingParishHomeState {
  final ParishModel parishModel;

  GetOnboardingParishByUidLoaded(this.parishModel);
}

class GetOnboardingParishByUidError extends OnboardingParishHomeState {
  final Failure failure;
  GetOnboardingParishByUidError(this.failure);
}

import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';

class OnboardingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class RegisterParishLoading extends OnboardingState {}

class RegisterParishLoaded extends OnboardingState {
  final ParishModel parishModel;
  RegisterParishLoaded(this.parishModel);
}

class RegisterParishError extends OnboardingState {
  final Failure failure;
  RegisterParishError(this.failure);
}

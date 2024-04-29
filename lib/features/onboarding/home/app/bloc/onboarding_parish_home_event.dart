import 'package:equatable/equatable.dart';

class OnboardingParishHomeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetOnboardingParishHomeEvent extends OnboardingParishHomeEvent {}

class GetOnboardingParishByUidEvent extends OnboardingParishHomeEvent {
  final String uuid;
  GetOnboardingParishByUidEvent(this.uuid);
}

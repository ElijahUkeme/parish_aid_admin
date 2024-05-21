import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';

import '../../data/model/parish_model.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class GetParishesLoading extends HomeState {}

class GetParishesLoaded extends HomeState {
  final ParishModel parishModel;
  GetParishesLoaded(this.parishModel);
}

class GetParishesError extends HomeState {
  final Failure failure;
  GetParishesError(this.failure);
}

class GetShowLoading extends HomeState {}

class GetShowLoaded extends HomeState {
  final ParishModel parishModel;
  GetShowLoaded(this.parishModel);
}

class GetShowError extends HomeState {
  final Failure failure;
  GetShowError(this.failure);
}

class UpdateParishLoading extends HomeState {}

class UpdateParishLoaded extends HomeState {
  final ParishModel parishModel;

  UpdateParishLoaded(this.parishModel);
}

class UpdateParishError extends HomeState {
  final Failure failure;
  UpdateParishError(this.failure);
}

class CreateParishLoading extends HomeState {}

class CreateParishLoaded extends HomeState {
  final ParishModel parishModel;
  CreateParishLoaded(this.parishModel);
}

class CreateParishError extends HomeState {
  final Failure failure;
  CreateParishError(this.failure);
}

class ApproveParishLoading extends HomeState {}

class ApproveParishLoaded extends HomeState {
  final ParishModel parishModel;
  ApproveParishLoaded(this.parishModel);
}

class ApproveParishError extends HomeState {
  final Failure failure;
  ApproveParishError(this.failure);
}

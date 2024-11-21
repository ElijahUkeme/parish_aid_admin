import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/events/app/home_event.dart';
import 'package:parish_aid_admin/features/home/data/model/get_parish_model.dart';
import 'package:parish_aid_admin/features/home/data/model/print_verification_code_model.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_model.dart';
import 'package:parish_aid_admin/features/home/data/model/verification_code_stat_model.dart';

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

class GetParishLoading extends HomeState {}

class GetParishLoaded extends HomeState {
  final GetParishModel parishModel;
  GetParishLoaded(this.parishModel);
}

class GetParishError extends HomeState {
  final Failure failure;
  GetParishError(this.failure);
}

class UpdateParishLoading extends HomeState {}

class UpdateParishLoaded extends HomeState {
  final GetParishModel parishModel;

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
  final GetParishModel parishModel;
  ApproveParishLoaded(this.parishModel);
}

class ApproveParishError extends HomeState {
  final Failure failure;
  ApproveParishError(this.failure);
}
class DeleteParishLoading extends HomeState{}
class DeleteParishLoaded extends HomeState{
  final bool status;
  DeleteParishLoaded(this.status);
}
class DeleteParishError extends HomeState{
  final Failure failure;
  DeleteParishError(this.failure);
}
class CreateVerificationCodeLoading extends HomeState{}
class CreateVerificationCodeLoaded extends HomeState{
  final VerificationCodeModel model;
  CreateVerificationCodeLoaded(this.model);
}
class CreateVerificationCodeError extends HomeState{
  final Failure failure;
  CreateVerificationCodeError(this.failure);
}
class UpdateVerificationCodeLoading extends HomeState{}
class UpdateVerificationCodeLoaded extends HomeState{
  final VerificationCodeModel model;
  UpdateVerificationCodeLoaded(this.model);
}
class UpdateVerificationCodeError extends HomeState{
  final Failure failure;
  UpdateVerificationCodeError(this.failure);
}
class PrintVerificationCodeLoading extends HomeState{}
class PrintVerificationCodeLoaded extends HomeState{
  final PrintVerificationCodeModel model;
  PrintVerificationCodeLoaded(this.model);
}
class PrintVerificationCodeError extends HomeState{
  final Failure failure;
  PrintVerificationCodeError(this.failure);
}
class GetVerificationCodeListLoading extends HomeState{}
class GetVerificationCodeListLoaded extends HomeState{
  final VerificationCodeModel model;
  GetVerificationCodeListLoaded(this.model);
}
class GetVerificationCodeListError extends HomeState{
  final Failure failure;
  GetVerificationCodeListError(this.failure);
}
class GetVerificationCodeStatLoading extends HomeState{
}
class GetVerificationCodeStatLoaded extends HomeState{
  final VerificationCodeStatModel model;
  GetVerificationCodeStatLoaded(this.model);
}
class GetVerificationCodeStatError extends HomeState{
  final Failure failure;
  GetVerificationCodeStatError(this.failure);
}
class ShowVerificationCodeLoading extends HomeState{}
class ShowVerificationCodeLoaded extends HomeState{
  final VerificationCodeData data;
  ShowVerificationCodeLoaded(this.data);
}
class ShowVerificationCodeError extends HomeState{
  final Failure failure;
  ShowVerificationCodeError(this.failure);
}
class DeleteVerificationCodeLoading extends HomeState{}
class DeleteVerificationCodeLoaded extends HomeState{
  final bool status;
  DeleteVerificationCodeLoaded(this.status);
}
class DeleteVerificationCodeError extends HomeState{
  final Failure failure;
  DeleteVerificationCodeError(this.failure);
}

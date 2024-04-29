import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/diocese/data/models/diocese_model.dart';

class DioceseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DioceseInitial extends DioceseState {}

class GetDioceseLoading extends DioceseState {}

class GetDioceseLoaded extends DioceseState {
  final DioceseModel dioceseModel;
  GetDioceseLoaded(this.dioceseModel);
}

class GetDioceseError extends DioceseState {
  final Failure failure;
  GetDioceseError(this.failure);
}

class ShowDioceseLoading extends DioceseState {}

class ShowDioceseLoaded extends DioceseState {
  final DioceseModel dioceseModel;
  ShowDioceseLoaded(this.dioceseModel);
}

class ShowDioceseError extends DioceseState {
  final Failure failure;
  ShowDioceseError(this.failure);
}

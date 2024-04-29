import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/lga/data/models/lga_model.dart';

class LgaState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LgaInitial extends LgaState {}

class LgaLoading extends LgaState {}

class LgaLoaded extends LgaState {
  final LgaModel lgaModel;
  LgaLoaded(this.lgaModel);
}

class LgaError extends LgaState {
  final Failure failure;
  LgaError(this.failure);
}

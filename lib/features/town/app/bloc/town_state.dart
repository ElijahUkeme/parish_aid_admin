import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/town/data/models/town_model.dart';

class TownState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TownInitial extends TownState {}

class GetTownLoading extends TownState {}

class GetTownLoaded extends TownState {
  final TownModel townModel;
  GetTownLoaded(this.townModel);
}

class GetTownError extends TownState {
  final Failure failure;

  GetTownError(this.failure);
}

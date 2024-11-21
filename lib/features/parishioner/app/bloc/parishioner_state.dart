import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_list_model.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_model.dart';

class ParishionerState extends Equatable{
  @override

  List<Object?> get props => [];

}
class ParishionerInitial extends ParishionerState{}
class CreateParishionerLoading extends ParishionerState{}
class CreateParishionerLoaded extends ParishionerState{
  final ParishionerModel parishionerModel;
  CreateParishionerLoaded(this.parishionerModel);
}
class CreateParishionerError extends ParishionerState{
  final Failure failure;
  CreateParishionerError(this.failure);
}
class UpdateParishionerLoading extends ParishionerState{}
class UpdateParishionerLoaded extends ParishionerState{
  final ParishionerModel parishionerModel;
  UpdateParishionerLoaded(this.parishionerModel);
}
class UpdateParishionerError extends ParishionerState{
  final Failure failure;
  UpdateParishionerError(this.failure);
}
class GetParishionersLoading extends ParishionerState{
}
class GetParishionersLoaded extends ParishionerState{
  final ParishionerListModel parishionerListModel;
  GetParishionersLoaded(this.parishionerListModel);
}
class GetParishionersError extends ParishionerState{
  final Failure failure;
  GetParishionersError(this.failure);
}
class GetParishionerLoading extends ParishionerState{}
class GetParishionerLoaded extends ParishionerState{
  final ParishionerModel parishionerModel;
  GetParishionerLoaded(this.parishionerModel);
}
class GetParishionerError extends ParishionerState{
  final Failure failure;
  GetParishionerError(this.failure);
}
class DeleteParishionerLoading extends ParishionerState{}
class DeleteParishionerLoaded extends ParishionerState{
  final bool status;
  DeleteParishionerLoaded(this.status);
}
class DeleteParishionerError extends ParishionerState{
  final Failure failure;
  DeleteParishionerError(this.failure);
}
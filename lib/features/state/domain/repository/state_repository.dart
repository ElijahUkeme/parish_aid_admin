import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/state/data/models/state_model.dart';
import 'package:parish_aid_admin/features/state/domain/usecases/get_state.dart';

abstract class StateRepository{
  Future<Either<Failure,StateModel>> getState(GetStateParams params);
}
import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_list_model.dart';
import 'package:parish_aid_admin/features/parishioner/data/model/parishioner_model.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/create_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/delete_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/get_parishioner.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/get_parishioners.dart';
import 'package:parish_aid_admin/features/parishioner/domain/usecases/update_parishioner.dart';

abstract class ParishionerRepository{
  Future<Either<Failure,ParishionerModel>> createParishioner(CreateParishionerParams params);
  Future<Either<Failure,ParishionerModel>> updateParishioner(UpdateParishionerParams params);
  Future<Either<Failure,ParishionerListModel>> getParishioners(GetParishionersParam param);
  Future<Either<Failure,ParishionerModel>> getParishioner(GetParishionerParams params);
  Future<Either<Failure,bool> > deleteParishioner(DeleteParishionerParams params);
}
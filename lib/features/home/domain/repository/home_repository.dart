import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/approve_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/create_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/delete_parish.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/get_show.dart';
import 'package:parish_aid_admin/features/home/domain/usecases/update_parish.dart';

abstract class HomeRepository {
  Future<Either<Failure, ParishModel>> getParishes();
  Future<Either<Failure, ParishModel>> getShow(GetShowParam param);
  Future<Either<Failure, ParishModel>> updateParish(UpdateParishParams params);
  Future<Either<Failure, ParishModel>> createParish(CreateParishParams params);
  Future<Either<Failure, ParishModel>> approveParish(ApproveParishParam param);
  Future<Either<Failure, bool>> deleteParish(DeleteParishParam param);
}

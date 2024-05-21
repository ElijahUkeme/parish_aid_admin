import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class GetParishes extends Usecase<ParishModel, NoParams> {
  final HomeRepository homeRepository;
  GetParishes(this.homeRepository);

  @override
  Future<Either<Failure, ParishModel>> call(params) {
    return homeRepository.getParishes();
  }
}

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/get_parish_model.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class GetParish extends Usecase<GetParishModel, GetParishParam> {
  final HomeRepository homeRepository;
  GetParish(this.homeRepository);

  @override
  Future<Either<Failure, GetParishModel>> call(GetParishParam params) {
    return homeRepository.getParish(params);
  }
}

class GetParishParam extends Equatable {
  final String parish;
  const GetParishParam({required this.parish});

  @override
  List<Object?> get props => [];
}

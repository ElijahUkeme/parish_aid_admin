import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/get_parish_model.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class ApproveParish extends Usecase<GetParishModel, ApproveParishParam> {
  final HomeRepository homeRepository;

  ApproveParish(this.homeRepository);

  @override
  Future<Either<Failure, GetParishModel>> call(ApproveParishParam params) {
    return homeRepository.approveParish(params);
  }
}

class ApproveParishParam extends Equatable {
  final String parish;
  const ApproveParishParam({required this.parish});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class ApproveParish extends Usecase<ParishModel, ApproveParishParam> {
  final HomeRepository homeRepository;

  ApproveParish(this.homeRepository);

  @override
  Future<Either<Failure, ParishModel>> call(ApproveParishParam params) {
    return homeRepository.approveParish(params);
  }
}

class ApproveParishParam extends Equatable {
  final int parish;
  const ApproveParishParam({required this.parish});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/home/domain/repository/home_repository.dart';

class DeleteParish extends Usecase<bool, DeleteParishParam> {
  final HomeRepository homeRepository;
  DeleteParish(this.homeRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteParishParam params) {
    return homeRepository.deleteParish(params);
  }
}

class DeleteParishParam extends Equatable {
  final String parish;
  const DeleteParishParam({required this.parish});

  @override
  // TODO: implement props
  List<Object?> get props => [parish];
}

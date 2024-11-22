import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/transaction/data/model/transaction_model.dart';
import 'package:parish_aid_admin/features/transaction/domain/repository/transaction_repository.dart';

class ShowTransaction extends Usecase<TransactionModel,ShowTransactionParams>{
  final TransactionRepository transactionRepository;

  ShowTransaction(this.transactionRepository);

  @override
  Future<Either<Failure, TransactionModel>> call(ShowTransactionParams params) {
    return transactionRepository.showTransaction(params);
  }
}

class ShowTransactionParams extends Equatable{
  final int parishId;
  final int transactionId;

  const ShowTransactionParams({required this.parishId,required this.transactionId});

  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/usecase/usecase.dart';
import 'package:parish_aid_admin/features/transaction/data/model/transaction_model.dart';
import 'package:parish_aid_admin/features/transaction/domain/repository/transaction_repository.dart';

class GetTransactions extends Usecase<List<TransactionModel>,GetTransactionsParam>{
  final TransactionRepository transactionRepository;

  GetTransactions(this.transactionRepository);

  @override
  Future<Either<Failure, List<TransactionModel>>> call(GetTransactionsParam param) {
   return transactionRepository.getTransactions(param);
  }
}

class GetTransactionsParam extends Equatable{
  final int parishId;

  const GetTransactionsParam({required this.parishId});

  @override
  List<Object?> get props => [];
}
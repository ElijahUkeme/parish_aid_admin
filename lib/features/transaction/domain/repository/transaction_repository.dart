import 'package:fpdart/fpdart.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/features/transaction/data/model/transaction_model.dart';
import 'package:parish_aid_admin/features/transaction/domain/usecases/get_transactions.dart';
import 'package:parish_aid_admin/features/transaction/domain/usecases/show_transaction.dart';

abstract class TransactionRepository{
  Future<Either<Failure,List<TransactionModel>>> getTransactions(GetTransactionsParam param);
  Future<Either<Failure,TransactionModel>> showTransaction(ShowTransactionParams params);
}
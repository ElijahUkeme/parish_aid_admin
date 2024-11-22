import 'package:fpdart/src/either.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';
import 'package:parish_aid_admin/core/service_runner/service_runner.dart';
import 'package:parish_aid_admin/features/transaction/data/model/transaction_model.dart';
import 'package:parish_aid_admin/features/transaction/data/sources/transaction_remote_source.dart';
import 'package:parish_aid_admin/features/transaction/domain/repository/transaction_repository.dart';
import 'package:parish_aid_admin/features/transaction/domain/usecases/get_transactions.dart';
import 'package:parish_aid_admin/features/transaction/domain/usecases/show_transaction.dart';

import '../../../../core/network_info/network_info.dart';

class TransactionRepositoryImpl extends TransactionRepository{

  final TransactionRemoteSource transactionRemoteSource;
  final NetworkInfo networkInfo;

  TransactionRepositoryImpl({
    required this.transactionRemoteSource,required this.networkInfo
});

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions(GetTransactionsParam param) {
   return ServiceRunner<List<TransactionModel>>(networkInfo: networkInfo)
       .runNetworkTask(()=>transactionRemoteSource.getTransactions(param));
  }

  @override
  Future<Either<Failure, TransactionModel>> showTransaction(ShowTransactionParams params) {
    return ServiceRunner<TransactionModel>(networkInfo: networkInfo)
        .runNetworkTask(()=>transactionRemoteSource.showTransaction(params));
  }

}
import 'package:equatable/equatable.dart';
import 'package:parish_aid_admin/core/failures/failure.dart';

import '../../data/model/transaction_model.dart';

class TransactionState extends Equatable{
  @override
  List<Object?> get props => [];
}

class TransactionInitial extends TransactionState{}

class GetTransactionLoading extends TransactionState{}
class GetTransactionLoaded extends TransactionState{
  final List<TransactionModel> transactions;
  GetTransactionLoaded(this.transactions);
}
class GetTransactionError extends TransactionState{
  final Failure failure;
  GetTransactionError(this.failure);
}

class ShowTransactionLoading extends TransactionState{}
class ShowTransactionLoaded extends TransactionState{
  final TransactionModel transaction;

  ShowTransactionLoaded(this.transaction);
}

class ShowTransactionError extends TransactionState{
  final Failure failure;
  ShowTransactionError(this.failure);
}
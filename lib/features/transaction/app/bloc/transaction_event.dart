import 'package:equatable/equatable.dart';

class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];

}
class GetTransactionsEvent extends TransactionEvent{
  final int parishId;
  GetTransactionsEvent({required this.parishId});
}

class ShowTransactionEvent extends TransactionEvent{
  final int parishId;
  final int transactionId;

  ShowTransactionEvent({required this.parishId,required this.transactionId});
}
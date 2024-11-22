import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/features/transaction/app/bloc/transaction_event.dart';
import 'package:parish_aid_admin/features/transaction/app/bloc/transaction_state.dart';
import 'package:parish_aid_admin/features/transaction/domain/usecases/get_transactions.dart';

import '../../domain/usecases/show_transaction.dart';

class TransactionBloc extends Bloc<TransactionEvent,TransactionState>{
  final GetTransactions getTransactions;
  final ShowTransaction showTransaction;

  TransactionBloc({required this.getTransactions,
                  required this.showTransaction}):super(TransactionInitial()){
    on<TransactionEvent>((event,emit) async {
      if(event is GetTransactionsEvent){
        emit(GetTransactionLoading());

        final result = await getTransactions(GetTransactionsParam(parishId: event.parishId));

        emit(result.fold((failure)=>GetTransactionError(failure), (transactions)=>GetTransactionLoaded(transactions)));
      }else if(event is ShowTransactionEvent){
        emit(ShowTransactionLoading());

        final result = await showTransaction(ShowTransactionParams(parishId: event.parishId, transactionId: event.transactionId));

        emit(result.fold((failure)=>ShowTransactionError(failure), (transaction)=>ShowTransactionLoaded(transaction)));
      }
    });
  }
}
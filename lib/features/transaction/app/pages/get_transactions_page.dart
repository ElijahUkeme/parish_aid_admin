
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/core/utils/string_extensions.dart';
import 'package:parish_aid_admin/core/widgets/small_empty_list.dart';
import 'package:parish_aid_admin/features/transaction/app/bloc/transaction_bloc.dart';
import 'package:parish_aid_admin/features/transaction/app/bloc/transaction_event.dart';
import 'package:parish_aid_admin/features/transaction/app/bloc/transaction_state.dart';
import 'package:parish_aid_admin/features/transaction/app/widgets/transaction_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/widgets/custom_top_snackbar.dart';
import '../../../../injection_container.dart';
import '../../../../widgets/auth/auth_widgets.dart';
import '../../data/model/transaction_model.dart';

class GetTransactionsPage extends StatefulWidget {
  const GetTransactionsPage({Key? key,this.parishId}) : super(key: key);

  final int? parishId;

  @override
  State<GetTransactionsPage> createState() => _GetTransactionsPageState();
}

class _GetTransactionsPageState extends State<GetTransactionsPage> with SingleTickerProviderStateMixin{

  bool loading = true;
  List<TransactionModel> transactions = [];
  String errorText = '';
  final transBloc = sl<TransactionBloc>();

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    getTransactions();
    //showTransaction();

  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TransactionBloc,TransactionState>(builder: (context,state){
      pp(state.runtimeType);
      if(state is GetTransactionLoading){

        loading = true;
      }else if(state is GetTransactionLoaded){
        loading = false;
        transactions = state.transactions;

      }else if(state is GetTransactionError){
        loading = false;
        errorText = state.failure.message;
        Future.delayed(const Duration(seconds: 1)).then((value) => {
          if (context.mounted)
            {
              Navigator.pop(context),
              showCustomTopSnackBar(context,
                  message: state.failure.message, color: Colors.red)
            }
        });
      }
      return loading
          ? Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue.shade900.withOpacity(0.8),
          ),
        ),
      )
          : Scaffold(
        appBar: appBar(),
        body: buildBody(size),
      );
    });
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: const IconThemeData(
          color: Colors.white
      ),
      backgroundColor: Colors.blue.shade900.withOpacity(0.8),
    );
  }

  Widget buildBody(Size size){
    return SmartRefresher(
      onRefresh: (){
        getTransactions();
      },
      controller: refreshController,
      enablePullDown: true,
      child: !loading?
      errorText.isEmptyOrNull
          ? const Center(
            child: SmallEmptyList(
                  iconData: Icons.free_cancellation_outlined,
                  title: 'No transactions',
                ),
          )
          : const Center(
            child: SmallEmptyList(
                  iconData: Icons.error,
                  title:
                  'Cannot load transactions.\nTry refreshing your Screen',
                ),
          ):Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context,index){
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TransactionCardWidget(transaction: transactions[index])
                );
              }),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
  
  Future<void> getTransactions()async{
    await Future.delayed(const Duration(seconds: 1));
    if( !transBloc.isClosed){
      BlocProvider.of<TransactionBloc>(context).add(GetTransactionsEvent(parishId: widget.parishId!));
    }
  }

  void showTransaction(){
    BlocProvider.of<TransactionBloc>(context).add(ShowTransactionEvent(parishId: widget.parishId!, transactionId: 12));
  }
}

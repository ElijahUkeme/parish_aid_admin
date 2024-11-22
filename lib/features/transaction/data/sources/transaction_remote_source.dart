
import 'dart:convert';

import 'package:parish_aid_admin/features/transaction/data/model/transaction_model.dart';
import 'package:parish_aid_admin/features/transaction/domain/usecases/get_transactions.dart';
import 'package:parish_aid_admin/features/transaction/domain/usecases/show_transaction.dart';

import '../../../../core/api/api_auth.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/helpers/custom_widgets.dart';
import '../../../../core/json_checker/json_checker.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/strings.dart';

abstract class TransactionRemoteSource{
  Future<List<TransactionModel>> getTransactions(GetTransactionsParam param);
  Future<TransactionModel> showTransaction(ShowTransactionParams params);
}

class TransactionRemoteSourceImpl extends TransactionRemoteSource{

  final http.Client client;
  final JsonChecker jsonChecker;

  TransactionRemoteSourceImpl({required this.client, required this.jsonChecker});

  @override
  Future<List<TransactionModel>> getTransactions(GetTransactionsParam param) async {

    String transactionGet = '$getTransactionsEndPoint/${param.parishId}/transactions';

    final response = await client
        .get(Uri.parse(transactionGet), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

    pp(data);
    final List<dynamic> transactionData = data['response']['data'];

    List<TransactionModel> transactionList = transactionData
    .map((item)=>TransactionModel.fromJson(item)).toList();

    return transactionList;
    } else if (data['response']['code'] == unsupportedAccessErrorCode) {
    throw ServerException(data['response']['message']);
    } else {
    throw ServerException(serverErrorMsg);
    }
    } else {
    throw const FormatException('Invalid response');
    }
  }

  @override
  Future<TransactionModel> showTransaction(ShowTransactionParams params) async {
    String transactionShow = '$getTransactionsEndPoint/${params.parishId}/transactions/show/${params.transactionId}';

    final response = await client
        .get(Uri.parse(transactionShow), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

    pp(data);

    TransactionModel transactionModel = TransactionModel.fromJson(data['response']['data']);

    return transactionModel;
    } else if (data['response']['code'] == unsupportedAccessErrorCode) {
    throw ServerException(data['response']['message']);
    } else {
    throw ServerException(serverErrorMsg);
    }
    } else {
    throw const FormatException('Invalid response');
    }
  }
}
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parish_aid_admin/core/helpers/custom_widgets.dart';
import 'package:parish_aid_admin/features/billing/data/models/subscription_model.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/get_billing_plans.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/get_subscriptions.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/initiate_billing_subscription.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/show_billing_plan.dart';
import 'package:parish_aid_admin/features/billing/domain/usecase/show_subscription.dart';

import '../../../../core/api/api_auth.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/json_checker/json_checker.dart';
import '../../../../core/utils/strings.dart';
import '../models/billing_plans_model.dart';

abstract class BillingPlansRemoteSource{
  Future<List<BillingPlansModel>> getBillingPlans(GetBillingPlansParam param);
  Future<BillingPlansModel> showBillingPlans(ShowBillingPlanParams params);
  Future<List<SubscriptionModel>> getSubscriptions(GetSubscriptionsParam param);
  Future<SubscriptionModel> showSubscription(ShowSubscriptionParams params);
  Future<SubscriptionModel> initiateSubscription(InitiateBillingSubscriptionParams params);

}
class BillingPlansRemoteSourceImpl extends BillingPlansRemoteSource{
  final http.Client client;
  final JsonChecker jsonChecker;

  BillingPlansRemoteSourceImpl({required this.client,required this.jsonChecker});

  @override
  Future<List<BillingPlansModel>> getBillingPlans(GetBillingPlansParam param) async {

    String billingsGet = '$getBillingsEndPoint/${param.parish}/billings/plans';
    final response = await client
        .get(Uri.parse(billingsGet), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {
      pp(data);

      List<BillingPlansModel> billingPlans =
      (data['response']['data'] as List<dynamic>).map((e)=>
          BillingPlansModel.fromJson(e)).toList();

    return billingPlans;
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
  Future<BillingPlansModel> showBillingPlans(ShowBillingPlanParams params) async {
    String billingsShow = '$showBillingEndPoint/${params.parish}/billings/plans/show/${params.plan}';
    final response = await client
        .get(Uri.parse(billingsShow), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    pp(response.body);

    if (data['status'] == 'OK') {

      pp(data);

      BillingPlansModel billingPlan = BillingPlansModel.fromJson(data['response']['data']);
      return billingPlan;
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
  Future<List<SubscriptionModel>> getSubscriptions(GetSubscriptionsParam param) async {
    String subscriptionsShow = '$getSubscriptionsEndPoint/${param.parish}/billings/subscriptions';
    final response = await client
        .get(Uri.parse(subscriptionsShow), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);

    List<SubscriptionModel> subscriptionPlan =
    (data['response']['data'] as List<dynamic>).map((e)=>SubscriptionModel.fromJson(e)).toList();

    return subscriptionPlan;
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
  Future<SubscriptionModel> showSubscription(ShowSubscriptionParams params) async {

    String subscriptionsShow = '$showSubscriptionEndPoint/${params.parish}/billings/subscriptions/show/${params.subscription}';
    final response = await client
        .get(Uri.parse(subscriptionsShow), headers: await getHeaders())
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);

    SubscriptionModel subscriptionPlan = SubscriptionModel.fromJson(data['response']['data']);
    return subscriptionPlan;
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
  Future<SubscriptionModel> initiateSubscription(InitiateBillingSubscriptionParams params) async {

    String initiate = '$initiateSubscriptionEndPoint/${params.parish}/billings/subscriptions/show/initiate';
    final body = {
      'parish_id': params.parish,
      'plan_id': params.planId,
      'method': params.method,
      'gateway': params.gateway
    };
    final response = await client
        .post(
        Uri.parse(initiate),
        body: json.encode(body),
        headers: await getHeaders(),
    )
        .timeout(const Duration(seconds: 20));

    pp(response.body);

    if (await jsonChecker.isJson(response.body)) {
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {

      pp(data);

    SubscriptionModel subscriptionPlan = data['response']['data'];
    return subscriptionPlan;
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
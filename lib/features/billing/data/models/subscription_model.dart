import 'package:parish_aid_admin/features/billing/data/models/billing_plans_model.dart';
import 'package:parish_aid_admin/features/users/data/models/user_auth_model.dart';

class SubscriptionModel {
  int? id;
  String? type;
  int? price;
  String? paidOn;
  String? expiresAt;
  String? status;
  String? createdAt;
  String? updatedAt;
  UserResponse? user;
  BillingPlansModel? plan;

  SubscriptionModel(this.id,this.type,this.price,this.paidOn,this.expiresAt,this.status,this.createdAt,
      this.updatedAt,this.user,this.plan);

  SubscriptionModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    type = json['type'];
    price = json['price'];
    paidOn = json['paid_on'];
    expiresAt = json['expires_at'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if(json['user'] !=null){
      user = UserResponse.fromJson(json['user']);
    }
    if(json['plan']!=null){
      plan = BillingPlansModel.fromJson(json['plan']);
    }
  }
}
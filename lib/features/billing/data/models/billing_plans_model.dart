import 'package:parish_aid_admin/features/group/data/model/group_model.dart';
import 'package:parish_aid_admin/features/home/data/model/parish_model.dart';

class BillingPlansModel {
  int? id;
  String? name;
  String? description;
  String? type;
  String? frequency;
  int? price;
  int? duration;
  String? target;
  String? status;
  String? createdAt;
  BillingPlansLogo? logo;
  Currency? currency;
  ParishData? parish;
  GroupData? group;
  List<Benefit>? benefits;

  BillingPlansModel(this.id,this.name,this.description,this.type,this.frequency,
      this.price,this.duration,this.target,this.status,this.createdAt,this.logo,this.currency,
      this.parish,this.group,this.benefits);

  BillingPlansModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    frequency = json['frequency'];
    price = json['price'];
    duration = json['duration'];
    target = json['target'];
    status = json['status'];
    createdAt = json['created_at'];
    if(json['logo'] !=null){
      logo = BillingPlansLogo.fromJson(json['logo']);
    }
    if(json['currency'] !=null){
      currency = Currency.fromJson(json['currency']);
    }
    if(json['parish'] !=null){
      parish = ParishData.fromJson(json['parish']);
    }
    if(json['group'] !=null){
      group = GroupData.fromJson(json['group']);
    }
    if(json['benefits'] !=null){
      benefits = [];
      json['benefits'].forEach((e){
        benefits!.add(Benefit.fromJson(e));
      });
    }
  }

}

class BillingPlansLogo{
   int? id;
   String? name;
   String? url;
   String? mimeType;
   String? size;
   String? formattedSize;
   String? createdAt;

   BillingPlansLogo(this.id,this.name,this.url,this.mimeType,this.size,this.formattedSize,this.createdAt);

   BillingPlansLogo.fromJson(Map<String,dynamic>json){
     id = json['id'];
     name = json['name'];
     url = json['url'];
     mimeType = json['mime_type'];
     size = json['size'];
     formattedSize = json['formatted_size'];
     createdAt = json['created_at'];
   }

}
class Currency{
   int? id;
  String? name;
  String? type;
  String? shortName;
  String? symbol;
  String? status;
  String? createdAt;

  Currency(this.id,this.name,this.type,this.shortName,this.symbol,this.status,this.createdAt);

  Currency.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
    shortName = json['short_name'];
    symbol = json['symbol'];
    status = json['status'];
    createdAt = json['created'];
  }
}
class Benefit{
   int? id;
   String? title;
   String? key;
   String? value;
   String? createdAt;
   String? updatedAt;

  Benefit(this.id,this.title,this.key,this.value,this.createdAt,this.updatedAt);

  Benefit.fromJson(Map<String,dynamic>json){
    id = json['id'];
    title =  json['title'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
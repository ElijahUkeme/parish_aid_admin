class UserAccountFetchModel {
  final String? terminus;
  final String? status;
  final ReturnResponse? response;

  UserAccountFetchModel({this.terminus, this.status, this.response});

  factory UserAccountFetchModel.fromJson(Map<String, dynamic> json) =>
      UserAccountFetchModel(
          terminus: json["terminus"],
          status: json["status"],
          response: ReturnResponse.fromJson(json["response"]));
}

class ReturnResponse {
  int? code;
  String? title;
  String? message;
  List<Parishes>? data;

  ReturnResponse({this.code,this.title,this.message,this.data});

  ReturnResponse.fromJson(Map<String,dynamic>json){
    code = json['code'];
    title = json['title'];
    message = json['message'];
    if(json['data'] !=null){
      json['data'].forEach((v){
        data!.add(Parishes.fromJson(v));
      });
    }
  }
}

class Parishes {
  int? id;
  String? name;
  String? acronym;
  String? address;
  String? phoneNo;
  String? parishPriestName;
  Town? town;
  State? state;
  Country? country;
  Diocese? diocese;
  Attachments? attachments;

  Parishes({this.id,this.name,this.acronym,this.address,this.phoneNo,this.parishPriestName,this.town,this.state,
  this.country,this.diocese,this.attachments});
  Parishes.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    acronym = json['acronym'];
    address = json['address'];
    phoneNo = json['phone_no'];
    parishPriestName = json['parish_priest_name'];
    if(json['town'] !=null){
      town = Town.fromJson(json['town']);
    }
    if(json['state'] !=null){
      state = State.fromJson(json['state']);
    }
    if(json['country'] !=null){
      country = Country.fromJson(json['country']);
    }
    if(json['diocese'] !=null){
      diocese = Diocese.fromJson(json['diocese']);
    }
    if(json['attachments'] !=null){
      attachments = Attachments.fromJson(json['attachments']);
    }
  }
}

class Town {
  int? id;
  String? name;
  Town({this.id, this.name});

  Town.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
class State{
  int? id;
  String? name;
  int? countryId;

  State({this.id,this.name,this.countryId});

  State.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
  }
}
class Country{
  int? id;
  String? name;

  Country({this.id,this.name});

  Country.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
  }
}
class Diocese{
  int? id;
  String? name;
  String? type;
  String? phoneNo;
  String? bishopName;
  Province? province;

  Diocese({this.id,this.name,this.type,this.phoneNo,this.bishopName,this.province});

  Diocese.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
    phoneNo = json['phone_no'];
    bishopName = json['bishop_name'];
    if(json['province'] !=null){
      province = Province.fromJson(json['province']);
    }
  }
}
class Province{
  int? id;
  String? name;
  String? areaCovered;

  Province({this.id,this.name,this.areaCovered});

  Province.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    areaCovered = json['area_covered'];
  }
}
class Attachments{
  Logo? logo;
  CoverImage? coverImage;

  Attachments({this.logo,this.coverImage});
  Attachments.fromJson(Map<String,dynamic>json){
    if(json['logo'] !=null){
      logo = Logo.fromJson(json['logo']);
    }
    if(json['cover_image'] !=null){
      coverImage = CoverImage.fromJson(json['cover_image']);
    }
  }
}
class Logo{
  int? id;
  String? name;
  String? url;
  String? mimeType;
  String? size;
  String? formattedSize;
  String? createdAt;

  Logo({this.id,this.name,this.url,this.mimeType,this.size,this.formattedSize,this.createdAt});

  Logo.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    url = json['url'];
    mimeType = json['mime_url'];
    size = json['size'];
    formattedSize = json['formatted_size'];
    createdAt = json['created_at'];
  }
}
class CoverImage{
  int? id;
  String? name;
  String? url;
  String? mimeType;
  String? size;
  String? formattedSize;
  String? createdAt;

  CoverImage({this.id,this.name,this.url,this.mimeType,this.size,this.formattedSize,this.createdAt});

  CoverImage.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    url = json['url'];
    mimeType = json['mime_url'];
    size = json['size'];
    formattedSize = json['formatted_size'];
    createdAt = json['created_at'];
  }
}

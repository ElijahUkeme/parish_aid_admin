class ParishModel {
  final String? terminus;
  final String? status;
  final ParishResponse? response;

  ParishModel({this.terminus, this.status, this.response});

  factory ParishModel.fromJson(Map<String, dynamic> json) => ParishModel(
      terminus: json["terminus"],
      status: json["status"],
      response: ParishResponse.fromJson(json["response"]));
}

class ParishResponse {
  int? code;
  String? title;
  String? message;
  Data? data;

  ParishResponse(
      {required code, required title, required message, required data}) {
    this.code = code;
    this.title = title;
    this.message = message;
    this.data = data;
  }

  ParishResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    title = json["title"];
    message = json["message"];
    if (json["data"] != null) {
      //data = Data.fromJson(json["data"]);
    }
  }
}

class Data {
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

  Data(
      {this.id,
      this.name,
      this.acronym,
      this.address,
      this.phoneNo,
      this.parishPriestName,
      this.town,
      this.state,
      this.country,
      this.diocese,
      this.attachments});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    acronym = json['acronym'];
    address = json['address'];
    phoneNo = json['phone_no'];
    parishPriestName = json['parish_priest_name'];
    if (json['town'] != null) {
      town = Town.fromJson(json['town']);
    }
    if (json['state'] != null) {
      state = State.fromJson(json['state']);
    }
    if (json['country'] != null) {
      country = Country.fromJson(json['country']);
    }
    if (json['diocese'] != null) {
      diocese = Diocese.fromJson(json['diocese']);
    }
    if (json['attachments'] != null) {
      attachments = Attachments.fromJson(json['attachments']);
    }
  }
}

class Town {
  int? id;
  String? name;

  Town({this.id, this.name});

  factory Town.fromJson(Map<String, dynamic> json) =>
      Town(id: json['id'], name: json['name']);
}

class State {
  int? id;
  String? name;
  int? countryId;

  State({this.id, this.name, this.countryId});

  factory State.fromJson(Map<String, dynamic> json) =>
      State(id: json['id'], name: json['name'], countryId: json['country_id']);
}

class Country {
  int? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Diocese {
  int? id;
  String? name;
  String? type;
  String? phoneNo;
  String? bishopName;
  Province? province;

  Diocese(
      {this.id,
      this.name,
      this.type,
      this.phoneNo,
      this.bishopName,
      this.province});

  Diocese.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['phone_no'];
    bishopName = json['bishop_name'];
    if (json['province'] != null) {
      province = Province.fromJson(json['province']);
    }
  }
}

class Province {
  int? id;
  String? name;
  String? areaCovered;

  Province({this.id, this.name, this.areaCovered});

  factory Province.fromJson(Map<String, dynamic> json) => Province(
      id: json['id'], name: json['name'], areaCovered: json['area_covered']);
}

class Attachments {
  Logo? logo;
  CoverImage? coverImage;

  Attachments({this.logo, this.coverImage});

  Attachments.fromJson(Map<String, dynamic> json) {
    if (json['logo'] != null) {
      if (json['logo'] != null) {
        logo = json['logo'];
      }
      if (json['cover_image'] != null) {
        coverImage = json['cover_image'];
      }
    }
  }
}

class Logo {
  int? id;
  String? name;
  String? url;
  String? mimeType;
  String? size;
  String? formattedSize;
  String? createdAt;

  Logo(
      {this.id,
      this.name,
      this.url,
      this.mimeType,
      this.size,
      this.formattedSize,
      this.createdAt});

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      mimeType: json['mime_type'],
      size: json['size'],
      formattedSize: json['formatted_size'],
      createdAt: json['created_at']);
}

class CoverImage {
  int? id;
  String? name;
  String? url;
  String? mimeType;
  String? size;
  String? formattedSize;
  String? createdAt;

  CoverImage(
      {this.id,
      this.name,
      this.url,
      this.mimeType,
      this.size,
      this.formattedSize,
      this.createdAt});

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      mimeType: json['mime_type'],
      size: json['size'],
      formattedSize: json['formatted_size'],
      createdAt: json['created_at']);
}

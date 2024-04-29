class TownModel {
  String? terminus;
  String? status;
  TownResponse? response;

  TownModel(this.terminus, this.status, this.response);

  TownModel.fromJson(Map<String, dynamic> json) {
    terminus = json['terminus'];
    status = json['status'];
    if (json['response'] != null) {
      response = json['response'];
    }
  }
}

class TownResponse {
  int? code;
  String? title;
  String? message;
  List<TownData>? data;

  TownResponse(this.code, this.title, this.message, this.data);

  TownResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    message = json['message'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(TownData.fromJson(json['data']));
      });
    }
  }
}

class TownData {
  int? id;
  String? name;

  TownData(this.id, this.name);

  TownData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class LgaModel {
  String? terminus;
  String? status;
  LgaResponse? response;

  LgaModel(this.terminus, this.status, this.response);

  LgaModel.fromJson(Map<String, dynamic> json) {
    terminus = json['terminus'];
    status = json['status'];
    if (json['response'] != null) {
      response = LgaResponse.fromJson(json['response']);
    }
  }
}

class LgaResponse {
  int? code;
  String? title;
  String? message;
  List<LgaData>? data;

  LgaResponse(this.code, this.title, this.message, this.data);

  LgaResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    message = json['message'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(LgaData.fromJson(v));
      });
    }
  }
}

class LgaData {
  int? id;
  String? name;
  int? stateId;

  LgaData(this.id, this.name, this.stateId);

  LgaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
  }
}

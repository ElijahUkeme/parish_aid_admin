class StateModel {
  String? terminus;
  String? status;
  StateResponse? response;

  StateModel(this.terminus,this.status,this.response);

  StateModel.fromJson(Map<String,dynamic>json){
    terminus = json['terminus'];
    status = json['status'];
    response = StateResponse.fromJson(json['response']);
  }

}
class StateResponse{
  int? code;
  String? message;
  String? title;
  List<StateData>? data;

  StateResponse(this.code,this.title,this.message,this.data);

  StateResponse.fromJson(Map<String,dynamic>json){
    code = json['code'];
    message = json['message'];
    title = json['title'];
    if(json['data'] !=null){
      data = [];
      json['data'].forEach((e){
        data!.add(StateData.fromJson(e));
      });
      }
    }
  }
class StateData{
  int? id;
  String? name;
  int? countryId;

  StateData(this.id,this.name,this.countryId);

  StateData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name = json['name'];
    countryId = json['country_id'];
  }
}

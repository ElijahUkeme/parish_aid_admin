class AuthModel {
  String? email;

  AuthModel({this.email});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    return data;
  }
}

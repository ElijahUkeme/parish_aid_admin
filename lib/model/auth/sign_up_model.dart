class SignUpModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  SignUpModel({this.firstName, this.lastName, this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["email"] = email;
    data["password"] = password;

    return data;
  }
}

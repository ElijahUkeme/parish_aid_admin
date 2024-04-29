import 'package:equatable/equatable.dart';

import '../../data/models/auth_user_model.dart';

class AuthUser extends Equatable {
  final String? terminus;
  final String? status;
  final ReturnResponse? response;

  const AuthUser({this.terminus, this.status, this.response});

  @override
  // TODO: implement props
  List<Object?> get props => [terminus, status, response];
}

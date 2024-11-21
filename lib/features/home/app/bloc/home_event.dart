import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetParishesEvent extends HomeEvent {}

class GetParishEvent extends HomeEvent {
  final String parish;
  GetParishEvent({required this.parish});
}

class UpdateParishEvent extends HomeEvent {
  final String? name;
  final String? acronym;
  final String? email;
  final String? phoneNo;
  final String? address;
  final String? dioceseId;
  final String? stateId;
  final String? lgaId;
  final String? town;
  final String? parishPriestName;
  final String? password;
  final String? registrarEmail;
  final String? logo;
  final String? coverImage;
  final String? parishId;

  UpdateParishEvent(
      {this.name,
      this.acronym,
      this.email,
      this.phoneNo,
      this.address,
      this.dioceseId,
      this.stateId,
      this.lgaId,
      this.town,
      this.parishPriestName,
      this.password,
      this.registrarEmail,
      this.logo,
      this.coverImage,
      this.parishId});
}

class CreateParishEvent extends HomeEvent {
  final String? name;
  final String? acronym;
  final String? email;
  final String? phoneNo;
  final String? address;
  final String? dioceseId;
  final int? stateId;
  final int? lgaId;
  final String? town;
  final String? parishPriestName;
  final String? password;
  final String? registrarEmail;
  final String? logo;
  final String? coverImage;

  CreateParishEvent(
      {this.name,
      this.acronym,
      this.email,
      this.phoneNo,
      this.address,
      this.dioceseId,
      this.stateId,
      this.lgaId,
      this.town,
      this.parishPriestName,
      this.password,
      this.registrarEmail,
      this.logo,
      this.coverImage});
}

class ApproveParishEvent extends HomeEvent {
  final String parish;
  ApproveParishEvent({required this.parish});
}
class DeleteParishEvent extends HomeEvent{
  final String parish;
  DeleteParishEvent({required this.parish});
}
class CreateVerificationCodeEvent extends HomeEvent{
  final int parishId;
  final int quantity;
  final String expiresAt;

  CreateVerificationCodeEvent({required this.parishId,required this.quantity,required this.expiresAt});
}

class UpdateVerificationCodeEvent extends HomeEvent{
  final int parishId;
  final int vCodeId;
  final int? printStatus;
  final String? status;
  final String? expiresAt;

  UpdateVerificationCodeEvent(this.parishId,this.vCodeId,this.printStatus,this.status,this.expiresAt);
}
class PrintVerificationCodeEvent extends HomeEvent{
  final int parishId;
  final int quantity;

  PrintVerificationCodeEvent(this.parishId,this.quantity);
}
class GetVerificationCodeListEvent extends HomeEvent{
  final int parish;
  GetVerificationCodeListEvent(this.parish);
}
class GetVerificationCodeStatEvent extends HomeEvent{
  final int parish;
  GetVerificationCodeStatEvent(this.parish);
}
class ShowVerificationCodeEvent extends HomeEvent{
  final int parish;
  final int code;
  ShowVerificationCodeEvent(this.parish,this.code);
}
class DeleteVerificationCodeEvent extends HomeEvent{
  final int parish;
  final int code;

  DeleteVerificationCodeEvent(this.parish,this.code);
}
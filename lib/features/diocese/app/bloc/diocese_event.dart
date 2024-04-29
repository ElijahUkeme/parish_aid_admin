import 'package:equatable/equatable.dart';

class DioceseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDioceseEvent extends DioceseEvent {}

class ShowDioceseEvent extends DioceseEvent {
  final int dioceseId;
  ShowDioceseEvent({required this.dioceseId});
}

import 'dart:ui';

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String title;
  final String message;
  const Failure(this.title, this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [title, message];
}

class ServerFailure extends Failure {
  final String title;
  final String message;
  const ServerFailure(this.title, this.message) : super(title, message);
}

class CacheFailure extends Failure {
  final String title;
  final String message;
  const CacheFailure(this.title, this.message) : super(title, message);
}

class CommonFailure extends Failure {
  const CommonFailure(final String title, final String message)
      : super(title, message);
}

class InternetFailure extends Failure {
  const InternetFailure(final String title, final String message)
      : super(title, message);
}

class ProcessFailure extends Failure {
  const ProcessFailure(final String title, final String message)
      : super(title, message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String title) : super(title, '');
}

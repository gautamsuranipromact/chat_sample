import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginNameChanged extends LoginEvent {
  const LoginNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

import 'package:chat_sample/page/login/login_status.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.pure,
    this.name = "",
    this.invalidName = false,
  });

  final LoginStatus status;
  final String name;
  final bool invalidName;

  LoginState copyWith({
    LoginStatus? status,
    String? name,
    bool? invalidName,
  }) {
    return LoginState(
      status: status ?? this.status,
      name: name ?? this.name,
      invalidName: invalidName ?? this.invalidName,
    );
  }

  @override
  List<Object> get props => [status, name, invalidName];
}

import 'package:chat_sample/authentication/bloc/authentication_repository.dart';
import 'package:chat_sample/page/login/bloc/login_event.dart';
import 'package:chat_sample/page/login/bloc/login_state.dart';
import 'package:chat_sample/page/login/login_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
    on<LoginNameChanged>(_onNameChanged);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onNameChanged(
    LoginNameChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.name.isEmpty || state.name.contains(" ")) {
      emit(state.copyWith(invalidName: true));
      return;
    }
    emit(state.copyWith(status: LoginStatus.submissionInProgress));
    try {
      await _authenticationRepository.logIn(name: state.name);

      emit(state.copyWith(status: LoginStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.submissionFailure));
    }
  }
}

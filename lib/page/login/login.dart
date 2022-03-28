import 'package:chat_sample/authentication/bloc/authentication_repository.dart';
import 'package:chat_sample/page/login/bloc/LoginBloc.dart';
import 'package:chat_sample/page/login/bloc/LoginEvent.dart';
import 'package:chat_sample/page/login/bloc/LoginState.dart';
import 'package:chat_sample/page/login/login_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Login());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        );
      },
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (LoginStatus.submissionFailure == state.status) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Start chat by enter you name',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Padding(padding: EdgeInsets.all(12)),
                _NameInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          (previous.name != current.name) ||
          (previous.invalidName != current.invalidName),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginNameChanged(username)),
            decoration: InputDecoration(
              errorText: state.invalidName
                  ? 'Name should not be blank and name should not contain any spaces'
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Login'),
                onPressed: () {
                  context.read<LoginBloc>().add(const LoginSubmitted());
                });
      },
    );
  }
}

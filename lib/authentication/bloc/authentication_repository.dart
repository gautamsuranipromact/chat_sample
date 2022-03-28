import 'dart:async';

import 'package:chat_sample/model/login_request.dart';
import 'package:chat_sample/model/login_response.dart';
import 'package:chat_sample/preferences.dart';
import 'package:chat_sample/rest/dio_client.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    if ((await Preferences.init())?.getString(Preferences.token) != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String name,
  }) async {
    LoginRequest request = LoginRequest(name: name);
    LoginResponse loginResponse = await DioClient().login(request: request);
    (await Preferences.init())?.setInt(Preferences.id, loginResponse.id!);
    (await Preferences.init())
        ?.setString(Preferences.name, loginResponse.name!);
    (await Preferences.init())
        ?.setString(Preferences.token, loginResponse.token!);
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() async {
    (await Preferences.init())?.clear();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

import 'package:chat_sample/model/login_request.dart';
import 'package:chat_sample/model/login_response.dart';
import 'package:chat_sample/model/message.dart';
import 'package:chat_sample/model/send_message_request.dart';
import 'package:chat_sample/model/user.dart';
import 'package:chat_sample/preferences.dart';
import 'package:chat_sample/rest/apis.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  static final DioClient _dioClient = DioClient._internal();

  factory DioClient() {
    return _dioClient;
  }

  DioClient._internal();

  Future<LoginResponse> login({required LoginRequest request}) async {
    Response userData =
        await _dio.post(APIConstants.login, data: request.toJson());

    if (userData.statusCode == 200) {
      return LoginResponse.fromJson(userData.data);
    }
    return throw Exception("Error on server");
  }

  Future<List<User>> getUser() async {
    await setHeaders();

    Response userData = await _dio.get(APIConstants.users);

    if (userData.statusCode == 200) {
      List<User> temp = [];
      for (int i = 0; i < userData.data.length; i++) {
        temp.add(User.fromJson(userData.data[i]));
      }
      return temp;
    }
    return throw Exception("Error on server");
  }

  Future<List<Message>> getMessage({required int userId}) async {
    await setHeaders();

    Response userData =
        await _dio.get(APIConstants.messages + userId.toString());

    if (userData.statusCode == 200) {
      List<Message> temp = [];
      for (int i = 0; i < userData.data.length; i++) {
        temp.add(Message.fromJson(userData.data[i]));
      }
      return temp;
    }
    return throw Exception("Error on server");
  }

  Future<void> sendMessage({required SendMessageRequest request}) async {
    await setHeaders();
    await _dio.post(APIConstants.messages, data: request.toJson());
  }

  setHeaders() async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] =
        (await Preferences.init())?.getString(Preferences.token);
  }
}

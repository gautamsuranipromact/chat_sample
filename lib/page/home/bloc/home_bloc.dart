import 'package:chat_sample/model/user.dart';
import 'package:chat_sample/page/home/bloc/home_event.dart';
import 'package:chat_sample/page/home/bloc/home_state.dart';
import 'package:chat_sample/rest/dio_client.dart';
import 'package:chat_sample/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<UserFetched>(
      _onUserFetched,
    );
  }

  Future<void> _onUserFetched(
    UserFetched event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (state.status == HomeStatus.initial) {
        _getDataFromDatabase(event, emit);
        if (await Util.hasNetwork()) {
          List<User> serverUsers = await DioClient().getUser();
          if (serverUsers.isNotEmpty) {
            await Util.getDataBase()!.insertMultipleUsers(serverUsers);
            await _getDataFromDatabase(event, emit);
          } else {
            return emit(state.copyWith(
              status: HomeStatus.success,
            ));
          }
        } else {
          return emit(state.copyWith(
            status: HomeStatus.success,
          ));
        }
      }
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> _getDataFromDatabase(event, emit) async {
    List<User> users = await Util.getDataBase()!.getUsers();
    if (users.isNotEmpty) {
      emit(state.copyWith(
        status: HomeStatus.success,
        users: users,
      ));
    }
  }
}

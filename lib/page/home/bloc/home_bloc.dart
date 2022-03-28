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
        List<User> users = await DioClient().getUser();
        Util.getDataBase()!.insertMultipleEntries(users);
        return emit(state.copyWith(
          status: HomeStatus.success,
          users: users,
          hasReachedMax: false,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}

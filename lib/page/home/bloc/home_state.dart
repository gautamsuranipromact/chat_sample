import 'package:chat_sample/model/user.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { initial, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.users = const <User>[],
    this.hasReachedMax = false,
  });

  final HomeStatus status;
  final List<User> users;
  final bool hasReachedMax;

  HomeState copyWith({
    HomeStatus? status,
    List<User>? users,
    bool? hasReachedMax,
  }) {
    return HomeState(
      status: status ?? this.status,
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${users.length} }''';
  }

  @override
  List<Object> get props => [status, users, hasReachedMax];
}

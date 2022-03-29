import 'package:chat_sample/authentication/bloc/authentication_bloc.dart';
import 'package:chat_sample/model/user.dart';
import 'package:chat_sample/page/chat/chat.dart';
import 'package:chat_sample/page/home/bloc/home_bloc.dart';
import 'package:chat_sample/page/home/bloc/home_event.dart';
import 'package:chat_sample/page/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(UserFetched()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home'), actions: [
          IconButton(
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
            icon: const Icon(Icons.logout),
          )
        ]),
        body: const UsersList(),
      ),
    );
  }
}

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.failure:
            return const Center(child: Text('failed to fetch users'));
          case HomeStatus.success:
            if (state.users.isEmpty) {
              return const Center(child: Text('no users'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return UserListItem(user: state.users[index]);
              },
              itemCount: state.users.length,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {}
}

class UserListItem extends StatelessWidget {
  const UserListItem({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        onTap: () => _message(user, context),
        title: Text(user.name ?? "", style: textTheme.titleMedium),
        dense: true,
      ),
    );
  }

  void _message(User user, BuildContext context) {
    Navigator.push(
      context,
      ChatPage.route(user.id ?? -1, user.name ?? ""),
    );
  }
}

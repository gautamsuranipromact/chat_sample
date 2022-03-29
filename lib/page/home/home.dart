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
        body: const PostsList(),
      ),
    );
  }
}

class PostsList extends StatefulWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
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
                return PostListItem(post: state.users[index]);
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

class PostListItem extends StatelessWidget {
  const PostListItem({Key? key, required this.post}) : super(key: key);

  final User post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        onTap: () => _message(post, context),
        title: Text(post.name ?? "", style: textTheme.titleMedium),
        dense: true,
      ),
    );
  }

  void _message(User post, BuildContext context) {
    Navigator.push(
      context,
      ChatPage.route(post.id ?? -1, post.name ?? ""),
    );
  }
}

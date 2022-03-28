import 'package:chat_sample/model/message.dart';
import 'package:chat_sample/page/chat/bloc/chat_bloc.dart';
import 'package:chat_sample/page/chat/bloc/chat_event.dart';
import 'package:chat_sample/page/chat/bloc/chat_state.dart';
import 'package:chat_sample/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(this.userId, this.name, {Key? key}) : super(key: key);

  final int userId;
  final String name;

  static Route route(int userId, String name) {
    return MaterialPageRoute<void>(builder: (_) => ChatPage(userId, name));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(userId)..add(MessageFetched()),
      child: Scaffold(
        appBar: AppBar(title: Text(name)),
        body: Column(
          children: const [
            Expanded(child: MessageList()),
            MessageSender(),
          ],
        ),
      ),
    );
  }
}

class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<MessageList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        switch (state.status) {
          case ChatStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case ChatStatus.success:
            if (state.messages.isEmpty) {
              return const Center(child: Text('no messages'));
            }
            return ListView.builder(
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                return PostListItem(post: state.messages[index]);
              },
              itemCount: state.messages.length,
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

  final Message post;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: post.isSent
          ? Container(
              padding: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    post.message ?? "",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      Util.formattedDate(
                          Util.stringToDate(post.createdDateTime!)),
                      style: const TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    post.message ?? "",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      Util.formattedDate(
                          Util.stringToDate(post.createdDateTime!)),
                      style: const TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class MessageSender extends StatelessWidget {
  const MessageSender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      height: 60,
      child: Row(children: [Expanded(child: _TextInput()), _SendButton()]),
    );
  }
}

class _TextInput extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) => (previous.text != current.text),
      builder: (context, state) {
        if (state.text.isEmpty) {
          textController.clear();
        }
        return TextField(
          controller: textController,
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<ChatBloc>().add(TextChanged(username)),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter Something',
            contentPadding: EdgeInsets.only(left: 15),
          ),
        );
      },
    );
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.sendStatus != current.sendStatus,
      builder: (context, state) {
        return state.sendStatus == SendStatus.submissionInProgress
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(),
              )
            : IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  context.read<ChatBloc>().add(SendMessage());
                });
      },
    );
  }
}

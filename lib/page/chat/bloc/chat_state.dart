import 'package:chat_sample/model/message.dart';
import 'package:equatable/equatable.dart';

enum ChatStatus { initial, success, failure }
enum SendStatus {
  pure,
  submissionInProgress,
  submissionSuccess,
  submissionFailure
}

class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.initial,
    this.sendStatus = SendStatus.pure,
    this.messages = const <Message>[],
    this.userId = -1,
    this.text = "",
  });

  final ChatStatus status;
  final SendStatus sendStatus;
  final List<Message> messages;
  final int userId;
  final String text;

  ChatState copyWith({
    ChatStatus? status,
    SendStatus? sendStatus,
    List<Message>? messages,
    bool? hasReachedMax,
    String? text,
    int? userId,
  }) {
    return ChatState(
      status: status ?? this.status,
      sendStatus: sendStatus ?? this.sendStatus,
      messages: messages ?? this.messages,
      text: text ?? this.text,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, posts: ${messages.length} }''';
  }

  @override
  List<Object> get props =>
      [status, messages, text, sendStatus, userId];
}

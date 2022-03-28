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
    this.hasReachedMax = false,
    this.userId = -1,
    this.text = "",
  });

  final ChatStatus status;
  final SendStatus sendStatus;
  final List<Message> messages;
  final bool hasReachedMax;
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
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      text: text ?? this.text,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${messages.length} }''';
  }

  @override
  List<Object> get props =>
      [status, messages, hasReachedMax, text, sendStatus, userId];
}

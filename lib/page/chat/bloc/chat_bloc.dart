import 'dart:async';

import 'package:chat_sample/model/message.dart';
import 'package:chat_sample/model/send_message_request.dart';
import 'package:chat_sample/page/chat/bloc/chat_event.dart';
import 'package:chat_sample/page/chat/bloc/chat_state.dart';
import 'package:chat_sample/preferences.dart';
import 'package:chat_sample/rest/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(int userId) : super(ChatState(userId: userId)) {
    on<MessageFetched>(_onMessageFetched);
    on<TextChanged>(_onTextChanged);
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onMessageFetched(
    MessageFetched event,
    Emitter<ChatState> emit,
  ) async {
    try {
      if (state.status == ChatStatus.initial) {
        List<Message> messages =
            await DioClient().getMessage(userId: state.userId);
        messages
            .sort((a, b) => b.createdDateTime!.compareTo(a.createdDateTime!));
        return emit(state.copyWith(
          status: ChatStatus.success,
          messages: messages,
          hasReachedMax: false,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: ChatStatus.failure));
    }
  }

  void _onTextChanged(
    TextChanged event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(
      text: event.text,
    ));
  }

  FutureOr<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (state.text.isNotEmpty) {
      emit(state.copyWith(
          sendStatus: SendStatus.submissionInProgress,
          messages: state.messages));
      SendMessageRequest request =
          SendMessageRequest(message: state.text, toUserId: state.userId);
      await DioClient().sendMessage(request: request);
      Message message = Message(
          toUserId: state.userId,
          message: state.text,
          createdDateTime: DateTime.now().toUtc().toString(),
          fromUserId: (await Preferences.init())?.getInt(Preferences.id));
      message.isSent = true;
      state.messages.insert(0, message);
      emit(state.copyWith(sendStatus: SendStatus.submissionSuccess, text: ""));
    }
  }
}

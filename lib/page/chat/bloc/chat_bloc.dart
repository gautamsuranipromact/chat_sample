import 'dart:async';

import 'package:chat_sample/model/message.dart';
import 'package:chat_sample/model/send_message_request.dart';
import 'package:chat_sample/page/chat/bloc/chat_event.dart';
import 'package:chat_sample/page/chat/bloc/chat_state.dart';
import 'package:chat_sample/preferences.dart';
import 'package:chat_sample/rest/dio_client.dart';
import 'package:chat_sample/util.dart';
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
        _getDataFromDatabase(event, emit);
        if (await Util.hasNetwork()) {
          List<Message> messages =
              await DioClient().getMessages(userId: state.userId);
          if (messages.isNotEmpty) {
            await Util.getDataBase()!.insertMultipleMessages(messages);
            await _getDataFromDatabase(event, emit);
          } else {
            return emit(state.copyWith(
              status: ChatStatus.success,
            ));
          }
        } else {
          return emit(state.copyWith(
            status: ChatStatus.success,
          ));
        }
      }
    } catch (_) {
      emit(state.copyWith(status: ChatStatus.failure));
    }
  }

  Future<void> _getDataFromDatabase(event, emit) async {
    int? myId = (await Preferences.init())?.getInt(Preferences.id);
    List<Message> messages =
        await Util.getDataBase()!.getMessagesByUser(myId!, state.userId);
    if (messages.isNotEmpty) {
      emit(state.copyWith(
        status: ChatStatus.success,
        messages: messages,
      ));
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
      if (!(await Util.hasNetwork())) {
        return;
      }
      emit(state.copyWith(sendStatus: SendStatus.submissionInProgress));
      SendMessageRequest request =
          SendMessageRequest(message: state.text, toUserId: state.userId);
      await DioClient().sendMessage(request: request);
      Message message = Message(
          toUserId: state.userId,
          message: state.text,
          createdDateTime: DateTime.now().toUtc().toString(),
          fromUserId: (await Preferences.init())?.getInt(Preferences.id));
      message.isSent = true;

      if (state.messages.isEmpty) {
        List<Message> tempMessages = [];
        tempMessages.insert(0, message);
        emit(state.copyWith(
          sendStatus: SendStatus.submissionSuccess,
          text: "",
          messages: tempMessages,
        ));
      } else {
        state.messages.insert(0, message);
        emit(state.copyWith(
          sendStatus: SendStatus.submissionSuccess,
          text: "",
        ));
      }
    }
  }
}

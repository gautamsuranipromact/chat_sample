import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MessageFetched extends ChatEvent {}

class TextChanged extends ChatEvent {
  TextChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

class SendMessage extends ChatEvent {}

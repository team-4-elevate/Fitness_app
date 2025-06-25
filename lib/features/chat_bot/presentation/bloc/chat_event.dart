part of 'chat_bloc.dart';

sealed class ChatEvent {}

class SendUserMessage extends ChatEvent {
  final String message;

  SendUserMessage(this.message);
}

class StartChatPressed extends ChatEvent {}

part of 'chat_bloc.dart';

sealed class ChatEvent {}

class SendUserMessage extends ChatEvent {
  final String message;

  SendUserMessage(this.message);
}

class StartChatPressed extends ChatEvent {}

class LoadConversation extends ChatEvent {
  final String id;

  LoadConversation(this.id);
}

class SaveConversation extends ChatEvent {}

class LoadAllConversations extends ChatEvent {}

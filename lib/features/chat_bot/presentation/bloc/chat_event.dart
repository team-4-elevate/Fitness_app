part of 'chat_bloc.dart';

sealed class ChatEvent {}

class SendUserMessage extends ChatEvent {
  final String message;

  SendUserMessage(this.message);
}

class StartChatPressed extends ChatEvent {}

class SelectConversation extends ChatEvent {
  final String id;

  SelectConversation(this.id);
}

class SaveConversation extends ChatEvent {}

class LoadAllConversations extends ChatEvent {}

class DeleteConversation extends ChatEvent {
  final String id;

  DeleteConversation(this.id);
}

part of 'chat_bloc.dart';

sealed class ChatState {}

class ChatWelcome extends ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageEntity> message;
  ChatLoaded(this.message);
}

class ChatError extends ChatState {
  final String error;
  ChatError(this.error);
}

class ConversationsLoaded extends ChatState {
  final List<ConversationEntity> conversations;
  ConversationsLoaded(this.conversations);
}

part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final AppStates uiState;
  final AppStates<MessageEntity> messageState;
  final AppStates<List<ConversationEntity>> conversationsState;
  final ConversationEntity? currentConversations;
  final List<MessageEntity>? messages;

  const ChatState({
    required this.uiState,
    required this.messageState,
    required this.conversationsState,
    this.messages,
    this.currentConversations,
  });

  ChatState copyWith({
    AppStates? uiState,
    AppStates<MessageEntity>? messageState,
    AppStates<List<ConversationEntity>>? conversationsState,
    ConversationEntity? currentConversations,
    List<MessageEntity>? messages,
  }) {
    return ChatState(
      uiState: uiState ?? this.uiState,
      messageState: messageState ?? this.messageState,
      conversationsState: conversationsState ?? this.conversationsState,
      currentConversations: currentConversations ?? this.currentConversations,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [
    uiState,
    messageState,
    conversationsState,
    currentConversations,
    messages,
  ];
}

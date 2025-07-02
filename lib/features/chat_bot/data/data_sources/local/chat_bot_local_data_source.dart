import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';

abstract interface class ChatBotLocalDataSource {
  Future<List<ConversationEntity>> getAllConversations();

  Future<ConversationEntity?> getConversationById(String id);

  Future<void> saveConversation(ConversationEntity conversation);

  Future<void> deleteConversation(String id);

  Future<void> updateConversation(String id, ConversationEntity conversation);

  Future<void> clearAllConversations();
}

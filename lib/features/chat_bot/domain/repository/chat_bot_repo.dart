import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';

abstract interface class ChatBotRepo {
  Future<void> startChat();
  Future<ApiResult<MessageEntity>> sendMessage(String message);
  Future<void> endChat();
  Future<List<ConversationEntity>> getAllConversations();
  Future<ConversationEntity?> getConversationById(String id);
  Future<void> saveConversation(ConversationEntity conversation);
  Future<void> deleteConversation(String id);
  Future<void> updateConversation(String id, ConversationEntity conversation);
  Future<void> clearAllConversations();
}

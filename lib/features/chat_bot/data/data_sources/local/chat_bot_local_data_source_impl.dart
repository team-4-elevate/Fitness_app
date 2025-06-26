import 'package:fitness_app/core/hive/hive_config.dart';
import 'package:fitness_app/features/chat_bot/data/data_sources/local/chat_bot_local_data_source.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatBotLocalDataSource)
class ChatBotLocalDataSourceImpl implements ChatBotLocalDataSource {
  final HiveService _hiveService;

  ChatBotLocalDataSourceImpl(this._hiveService);

  @override
  Future<List<ConversationEntity>> getAllConversations() async {
    final box = await _hiveService.conversationBox;
    return box.values.toList();
  }

  @override
  Future<ConversationEntity?> getConversationById(String id) async {
    final box = await _hiveService.conversationBox;
    return box.get(id);
  }

  @override
  Future<void> saveConversation(ConversationEntity conversation) async {
    final box = await _hiveService.conversationBox;
    return box.put(conversation.id, conversation);
  }

  @override
  Future<void> updateConversation(
    String id,
    ConversationEntity conversation,
  ) async {
    final box = await _hiveService.conversationBox;
    var existingConversation = box.get(id);

    if (existingConversation != null) {
      existingConversation.title = conversation.title;
      existingConversation.messages = conversation.messages;
      return box.put(id, existingConversation);
    }
  }

  @override
  Future<void> deleteConversation(String id) async {
    final box = await _hiveService.conversationBox;
    box.delete(id);
  }

  @override
  Future<void> clearAllConversations() async {
    final box = await _hiveService.conversationBox;
    box.clear();
  }
}

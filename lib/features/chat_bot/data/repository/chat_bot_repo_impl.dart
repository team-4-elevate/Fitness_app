import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/chat_bot/data/data_sources/local/chat_bot_local_data_source.dart';
import 'package:fitness_app/features/chat_bot/data/data_sources/remote/chat_bot_remote_data_source.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/repository/chat_bot_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatBotRepo)
class ChatBotRepoImpl implements ChatBotRepo {
  final ChatBotRemoteDataSource _remoteDataSource;
  final ChatBotLocalDataSource _localDataSource;

  ChatBotRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<void> startChat() async {}

  @override
  Future<ApiResult<MessageEntity>> sendMessage(String message) async {
    try {
      final response = await _remoteDataSource.sendMessage(message);
      return ApiSuccess(response);
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }

  @override
  Future<void> endChat() async {}

  @override
  Future<List<ConversationEntity>> getAllConversations() async {
    try {
      return await _localDataSource.getAllConversations();
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }

  @override
  Future<ConversationEntity?> getConversationById(String id) async {
    try {
      return await _localDataSource.getConversationById(id);
    } catch (e) {
      throw Exception('Failed to get conversation: $e');
    }
  }

  @override
  Future<void> saveConversation(ConversationEntity conversation) async {
    try {
      await _localDataSource.saveConversation(conversation);
    } catch (e) {
      throw Exception('Failed to save conversation: $e');
    }
  }

  @override
  Future<void> deleteConversation(String id) async {
    try {
      await _localDataSource.deleteConversation(id);
    } catch (e) {
      throw Exception('Failed to delete conversation: $e');
    }
  }

  @override
  Future<void> updateConversation(
    String id,
    ConversationEntity conversation,
  ) async {
    try {
      await _localDataSource.updateConversation(id, conversation);
    } catch (e) {
      throw Exception('Failed to update conversation: $e');
    }
  }

  @override
  Future<void> clearAllConversations() async {
    try {
      await _localDataSource.clearAllConversations();
    } catch (e) {
      throw Exception('Failed to clear conversations: $e');
    }
  }
}

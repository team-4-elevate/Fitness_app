import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';

abstract interface class ChatBotRemoteDataSource {
  Future<MessageEntity> sendMessage(String message);
}

import 'dart:typed_data';

import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';

abstract interface class ChatBotRemoteDataSource {
  Future<MessageEntity> sendMessage(
    List<MessageEntity> conversationHistory,
    String message,
  );
  Future<MessageEntity> sendMessageWithImage(
    List<MessageEntity> conversationHistory,
    String message,
    Uint8List imageBytes,
  );
}

import 'dart:typed_data';

import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/repository/chat_bot_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendMessageUsecase {
  final ChatBotRepo _chatBotRepo;

  SendMessageUsecase(this._chatBotRepo);

  Future<ApiResult<MessageEntity>> call({
    required List<MessageEntity> history,
    required String message,
    Uint8List? imageBytes,
  }) {
    return _chatBotRepo.sendMessage(
      conversationHistory: history,
      message: message,
      imageBytes: imageBytes,
    );
  }
}

import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/repository/chat_bot_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveConversationUsecase {
  final ChatBotRepo _chatBotRepo;
  SaveConversationUsecase(this._chatBotRepo);

  Future<void> call(ConversationEntity conversation) async {
    return await _chatBotRepo.saveConversation(conversation);
  }
}

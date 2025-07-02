import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/repository/chat_bot_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectConversationUsecase {
  final ChatBotRepo _chatBotRepo;
  SelectConversationUsecase(this._chatBotRepo);

  Future<ConversationEntity> call(String id) async {
    final conversation = await _chatBotRepo.getConversationById(id);
    return conversation!;
  }
}

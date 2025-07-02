import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/repository/chat_bot_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllConversationUsecase {
  final ChatBotRepo _chatBotRepo;

  GetAllConversationUsecase(this._chatBotRepo);

  Future<List<ConversationEntity>> call() async {
    return await _chatBotRepo.getAllConversations();
  }
}

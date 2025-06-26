import 'package:fitness_app/features/chat_bot/domain/repository/chat_bot_repo.dart';

class StartConversationUsecase {
  final ChatBotRepo chatBotRepo;
  StartConversationUsecase(this.chatBotRepo);
  Future<void> call() async {
    return await chatBotRepo.startChat();
  }

}

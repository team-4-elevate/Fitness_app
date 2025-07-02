import 'package:fitness_app/features/chat_bot/domain/repository/chat_bot_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteConversationUsecase {
  final ChatBotRepo _repo;
  DeleteConversationUsecase(this._repo);
  Future<void> call(String id) => _repo.deleteConversation(id);
}

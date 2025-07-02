import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class NewConversationUsecase {
  Future<ConversationEntity> call() async {
    final uuid = Uuid();
    return ConversationEntity(
      id: uuid.v4(),
      title: "New Conversation",
      messages: [
        MessageEntity(
          isUser: false,
          message: "Hello How Can I Assist You Today?",
          date: DateTime.now(),
        ),
      ],
    );
  }
}

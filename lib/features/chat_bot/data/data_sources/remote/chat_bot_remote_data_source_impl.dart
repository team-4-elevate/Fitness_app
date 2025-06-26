import 'package:fitness_app/features/chat_bot/data/data_sources/remote/chat_bot_remote_data_source.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatBotRemoteDataSource)
class ChatBotRemoteDataSourceImpl implements ChatBotRemoteDataSource {
  final GenerativeModel _gemini;
  ChatBotRemoteDataSourceImpl(this._gemini);

  @override
  Future<MessageEntity> sendMessage(String message) async {
    try {
      final response = await _gemini.generateContent([Content.text(message)]);
      if (response.text == null || response.text!.isEmpty) {
        throw Exception('Something went wrong, please try again later.');
      }
      return MessageEntity(
        isUser: false,
        message: response.text!,
        date: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}

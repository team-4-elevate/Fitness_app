import 'dart:typed_data';
import 'package:fitness_app/features/chat_bot/data/data_sources/remote/chat_bot_remote_data_source.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatBotRemoteDataSource)
class ChatBotRemoteDataSourceImpl implements ChatBotRemoteDataSource {
  final GenerativeModel _gemini;
  ChatBotRemoteDataSourceImpl(this._gemini);

  @override
  Future<MessageEntity> sendMessage(
    List<MessageEntity> conversationHistory,
    String message,
  ) async {
    try {
      final chat = _gemini.startChat(
        history: _mapHistoryToContent(conversationHistory),
      );

      final response = await chat.sendMessage(Content.text(message));

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

  @override
  Future<MessageEntity> sendMessageWithImage(
    List<MessageEntity> conversationHistory,
    String message,
    Uint8List imageBytes,
  ) async {
    try {
      final chat = _gemini.startChat(
        history: _mapHistoryToContent(conversationHistory),
      );

      final content = Content.multi([
        TextPart(message),
        DataPart('image/jpeg', imageBytes),
      ]);

      final response = await chat.sendMessage(content);

      if (response.text == null || response.text!.isEmpty) {
        throw Exception('No response from Gemini.');
      }

      return MessageEntity(
        isUser: false,
        message: response.text!,
        date: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to send image message: $e');
    }
  }

  List<Content> _mapHistoryToContent(List<MessageEntity> history) {
    return history.where((msg) => msg.message != 'Typing').map((message) {
      final role = message.isUser ? 'user' : 'model';
      return Content(role, [TextPart(message.message ?? '')]);
    }).toList();
  }
}

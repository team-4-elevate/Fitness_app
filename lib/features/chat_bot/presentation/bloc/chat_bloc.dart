import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<MessageEntity> messages = [
    MessageEntity(
      isUser: false,
      message: "Hello How Can I Assist You Today ?",
      date: DateTime.now(),
    ),
  ];

  static const apiKey = "AIzaSyA8inbFv_QBQlPtvXgGvYZEsMRDZBZ4Wq8";

  final GenerativeModel model = GenerativeModel(
    model: 'models/gemini-2.5-flash-lite-preview-06-17',
    apiKey: apiKey,
  );

  ChatBloc() : super(ChatWelcome()) {
    on<StartChatPressed>((event, emit) {
      emit(ChatInitial());
    });

    on<SendUserMessage>(_onSendUserMessage);
  }

  Future<void> _onSendUserMessage(
    SendUserMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (event.message.isEmpty) return;

    emit(ChatLoading());

    messages.add(
      MessageEntity(isUser: true, message: event.message, date: DateTime.now()),
    );

    final typingMessage = MessageEntity(
      isUser: false,
      message: 'Typing',
      date: DateTime.now(),
    );
    messages.add(typingMessage);
    emit(ChatLoaded(List.from(messages)));

    try {
      final response = await model.generateContent([
        Content.text(event.message),
      ]);

      messages.remove(typingMessage);

      messages.add(
        MessageEntity(
          isUser: false,
          message: response.text ?? "",
          date: DateTime.now(),
        ),
      );

      emit(ChatLoaded(List.from(messages)));
    } catch (e) {
      emit(ChatError(e.toString()));
    }

    // emit(ChatLoaded(List.from(messages)));

    // final response = await model.generateContent([
    //   Content.text(event.message),
    // ]);

    // messages.add(
    //   MessageEntity(
    //     isUser: false,
    //     message: response.text ?? "",
    //     date: DateTime.now(),
    //   ),
    // );

    // emit(ChatLoaded(List.from(messages)));
  }
}

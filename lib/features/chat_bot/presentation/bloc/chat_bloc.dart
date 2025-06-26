import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/repository/chat_bot_repo.dart';
import 'package:fitness_app/features/chat_bot/domain/usecase/send_message_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUsecase _sendMessageUsecase;
  final ChatBotRepo _chatBotRepo;

  ConversationEntity? currentConversation;
  final List<MessageEntity> messages = [];

  ChatBloc(this._sendMessageUsecase, this._chatBotRepo) : super(ChatWelcome()) {
    on<StartChatPressed>(_onStartChatPressed);
    on<SendUserMessage>(_onSendUserMessage);
    on<LoadConversation>(_onLoadConversation);
    on<SaveConversation>(_onSaveConversation);
    on<LoadAllConversations>(_onLoadAllConversations);
  }

  Future<void> _onStartChatPressed(
    StartChatPressed event,
    Emitter<ChatState> emit,
  ) async {
    final uuid = Uuid();
    currentConversation = ConversationEntity(
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
    messages.clear();
    messages.addAll(currentConversation!.messages);
    emit(ChatLoaded(messages));
  }

  Future<void> _onSendUserMessage(
    SendUserMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (event.message.isEmpty) return;

    emit(ChatLoading());

    final userMessage = MessageEntity(
      isUser: true,
      message: event.message,
      date: DateTime.now(),
    );
    messages.add(userMessage);
    currentConversation?.messages.add(userMessage);

    final typingMessage = MessageEntity(
      isUser: false,
      message: 'Typing',
      date: DateTime.now(),
    );
    messages.add(typingMessage);
    emit(ChatLoaded(messages));

    try {
      final response = await _sendMessageUsecase(event.message);
      response.when(
        success: (MessageEntity response) {
          messages.remove(typingMessage);
          messages.add(response);
          currentConversation?.messages.add(response);
          final lastMessage = response.message.split('\n').first;
          currentConversation?.title =
              lastMessage.length > 30
                  ? lastMessage.substring(0, 30)
                  : lastMessage;
          emit(ChatLoaded(messages));
        },
        failure: (String error) {
          messages.remove(typingMessage);
          emit(ChatError(error));
        },
      );
    } catch (e) {
      messages.remove(typingMessage);
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onLoadConversation(
    LoadConversation event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final conversation = await _chatBotRepo.getConversationById(event.id);
      if (conversation != null) {
        currentConversation = conversation;
        messages.clear();
        messages.addAll(conversation.messages);
        emit(ChatLoaded(messages));
      } else {
        emit(ChatError("Conversation not found"));
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSaveConversation(
    SaveConversation event,
    Emitter<ChatState> emit,
  ) async {
    try {
      if (currentConversation != null &&
          currentConversation!.messages.isNotEmpty) {
        await _chatBotRepo.saveConversation(currentConversation!);
      }
    } catch (e) {
      emit(ChatError("Failed to save conversation: $e"));
    }
  }

  Future<void> _onLoadAllConversations(
    LoadAllConversations event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final conversations = await _chatBotRepo.getAllConversations();
      emit(ConversationsLoaded(conversations));
    } catch (e) {
      emit(ChatError("Failed to load conversations: $e"));
    }
  }
}

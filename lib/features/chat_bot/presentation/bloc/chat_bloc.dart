import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/usecase/delete_conversation_usecase.dart';
import 'package:fitness_app/features/chat_bot/domain/usecase/get_all_conversation_usecase.dart';
import 'package:fitness_app/features/chat_bot/domain/usecase/new_conversation_usecase.dart';
import 'package:fitness_app/features/chat_bot/domain/usecase/save_conversation_usecase.dart';
import 'package:fitness_app/features/chat_bot/domain/usecase/select_conversation_usecase.dart';
import 'package:fitness_app/features/chat_bot/domain/usecase/send_message_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUsecase _sendMessageUsecase;
  final NewConversationUsecase _newConversationUsecase;
  final SelectConversationUsecase _selectConversationUsecase;
  final GetAllConversationUsecase _getAllConversationUsecase;
  final SaveConversationUsecase _saveConversationUsecase;
  final DeleteConversationUsecase _deleteConversationUsecase;

  ChatBloc(
    this._sendMessageUsecase,
    this._newConversationUsecase,
    this._selectConversationUsecase,
    this._getAllConversationUsecase,
    this._saveConversationUsecase,
    this._deleteConversationUsecase,
  ) : super(
          ChatState(
            uiState: InitialState(),
            messageState: InitialState(),
            conversationsState: InitialState(),
          ),
        ) {
    on<StartChatPressed>(_onStartChatPressed);
    on<SendUserMessage>(_onSendUserMessage);
    on<SelectConversation>(_onSelectConversation);
    on<SaveConversation>(_onSaveConversation);
    on<LoadAllConversations>(_onLoadAllConversations);
    on<DeleteConversation>(_onDeleteConversation);
  }

  Future<void> _onStartChatPressed(
    StartChatPressed event,
    Emitter<ChatState> emit,
  ) async {
    final currentConversation = await _newConversationUsecase();
    emit(
      state.copyWith(
        uiState: SuccessState(),
        currentConversations: currentConversation,
        messages: currentConversation.messages,
      ),
    );
  }

  Future<void> _onSendUserMessage(
    SendUserMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (event.message.isEmpty) return;

    final userMessage = MessageEntity(
      isUser: true,
      message: event.message,
      date: DateTime.now(),
      type: MessageType.normal,
    );

    final oldMessages = List<MessageEntity>.from(state.messages ?? []);
    final updatedMessages = [...oldMessages, userMessage];

    emit(
      state.copyWith(messageState: LoadingState(), messages: updatedMessages),
    );

    final typingMessage = MessageEntity(
      isUser: false,
      type: MessageType.typing,
    );

    updatedMessages.add(typingMessage);

    emit(
      state.copyWith(messageState: LoadingState(), messages: updatedMessages),
    );

    try {
      final response = await _sendMessageUsecase(
        history: oldMessages,
        message: event.message,
      );
      response.when(
        success: (msg) {
          updatedMessages.remove(typingMessage);
          updatedMessages.add(msg);

          final updatedConversation = state.currentConversations?.copyWith(
            messages: updatedMessages,
            title: msg.message!.split('\n').first.substring(0, 30),
          );
          _saveConversationUsecase.call(updatedConversation!);

          emit(
            state.copyWith(
              messages: updatedMessages,
              messageState: SuccessState(msg),
              currentConversations: updatedConversation,
            ),
          );
        },
        failure: (error) {
          updatedMessages.remove(typingMessage);

          final errorMessage = MessageEntity(
            isUser: false,
            message: 'Something went wrong, please try again later.',
            type: MessageType.error,
          );

          updatedMessages.add(errorMessage);

          emit(
            state.copyWith(
              messageState: ErrorState(error),
              messages: updatedMessages,
            ),
          );
        },
      );
    } catch (e) {
      updatedMessages.remove(typingMessage);

      final errorMessage = MessageEntity(
        isUser: false,
        message: 'Something went wrong, please try again later.',
        type: MessageType.error,
      );

      updatedMessages.add(errorMessage);

      emit(
        state.copyWith(
          messageState: ErrorState(e.toString()),
          messages: updatedMessages,
        ),
      );
    }
  }

  Future<void> _onSelectConversation(
    SelectConversation event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(state.copyWith(conversationsState: LoadingState()));

      final conversation = await _selectConversationUsecase.call(event.id);

      emit(
        state.copyWith(
          uiState: SuccessState(),
          currentConversations: conversation,
          messages: conversation.messages,
          messageState: SuccessState(),
          conversationsState: SuccessState([conversation]),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          conversationsState: ErrorState('Conversation not found'),
        ),
      );
    }
  }

  Future<void> _onSaveConversation(
    SaveConversation event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(conversationsState: LoadingState()));
    try {
      final conversation = state.currentConversations;
      if (conversation != null && conversation.messages.isNotEmpty) {
        await _saveConversationUsecase.call(conversation);
      }
      emit(state.copyWith(conversationsState: SuccessState()));
    } catch (e) {
      emit(state.copyWith(conversationsState: ErrorState(e.toString())));
    }
  }

  Future<void> _onLoadAllConversations(
    LoadAllConversations event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(conversationsState: LoadingState()));
    try {
      final conversations = await _getAllConversationUsecase.call();
      emit(state.copyWith(conversationsState: SuccessState(conversations)));
    } catch (e) {
      emit(state.copyWith(conversationsState: ErrorState(e.toString())));
    }
  }

  Future<void> _onDeleteConversation(
    DeleteConversation event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(conversationsState: LoadingState()));
    try {
      await _deleteConversationUsecase.call(event.id);
      final conversations = await _getAllConversationUsecase.call();
      if (state.currentConversations?.id == event.id) {
        final currentConversation = await _newConversationUsecase.call();
        emit(
          state.copyWith(
            uiState: SuccessState(),
            currentConversations: currentConversation,
            messages: currentConversation.messages,
            messageState: SuccessState(),
          ),
        );
      }
      emit(state.copyWith(conversationsState: SuccessState(conversations)));
    } catch (e) {
      emit(state.copyWith(conversationsState: ErrorState(e.toString())));
    }
  }
}

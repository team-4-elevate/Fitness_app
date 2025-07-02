import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';

class ConversationEntity {
  final String id;
  String title;
  List<MessageEntity> messages;

  ConversationEntity({
    required this.id,
    required this.title,
    required this.messages,
  });

  factory ConversationEntity.fromJson(Map<String, dynamic> json) {
    return ConversationEntity(
      id: json['id'],
      title: json['title'],
      messages:
          (json['messages'] as List)
              .map((m) => MessageEntity.fromJson(m))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'messages': messages.map((m) => m.toJson()).toList(),
  };

  ConversationEntity copyWith({
    String? id,
    String? title,
    List<MessageEntity>? messages,
  }) {
    return ConversationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      messages: messages ?? this.messages,
    );
  }
}

class MessageEntity {
  final bool isUser;
  final String? message;
  final DateTime? date;
  final MessageType type;

  MessageEntity({
    required this.isUser,
    this.message,
    this.date,
    this.type = MessageType.normal,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      isUser: json['isUser'],
      message: json['message'],
      date: DateTime.parse(json['date']),
      type: MessageType.values[json['type']],
    );
  }

  Map<String, dynamic> toJson() => {
    'isUser': isUser,
    'message': message,
    'date': date?.toIso8601String() ?? DateTime.now().toIso8601String(),
    'type': type,
  };
}

enum MessageType { normal, typing, error }

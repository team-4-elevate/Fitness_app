class MessageEntity {
  final bool isUser;
  final String message;
  final DateTime date;

  MessageEntity({
    required this.isUser,
    required this.message,
    required this.date,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      isUser: json['isUser'],
      message: json['message'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
    'isUser': isUser,
    'message': message,
    'date': date.toIso8601String(),
  };
}

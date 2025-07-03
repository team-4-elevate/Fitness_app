// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ConversationEntityAdapter extends TypeAdapter<ConversationEntity> {
  @override
  final typeId = 0;

  @override
  ConversationEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConversationEntity(
      id: fields[0] as String,
      title: fields[1] as String,
      messages: (fields[2] as List).cast<MessageEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, ConversationEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MessageEntityAdapter extends TypeAdapter<MessageEntity> {
  @override
  final typeId = 1;

  @override
  MessageEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageEntity(
      isUser: fields[0] as bool,
      message: fields[1] as String?,
      date: fields[2] as DateTime?,
      type: fields[3] == null ? MessageType.normal : fields[3] as MessageType,
    );
  }

  @override
  void write(BinaryWriter writer, MessageEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isUser)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MessageTypeAdapter extends TypeAdapter<MessageType> {
  @override
  final typeId = 2;

  @override
  MessageType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MessageType.normal;
      case 1:
        return MessageType.typing;
      case 2:
        return MessageType.error;
      default:
        return MessageType.normal;
    }
  }

  @override
  void write(BinaryWriter writer, MessageType obj) {
    switch (obj) {
      case MessageType.normal:
        writer.writeByte(0);
      case MessageType.typing:
        writer.writeByte(1);
      case MessageType.error:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

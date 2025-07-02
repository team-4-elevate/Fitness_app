// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class ConversationEntityAdapter extends TypeAdapter<ConversationEntity> {
  @override
  final typeId = 2;

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
  final typeId = 3;

  @override
  MessageEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageEntity(
      isUser: fields[0] as bool,
      message: fields[1] as String,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MessageEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isUser)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.date);
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

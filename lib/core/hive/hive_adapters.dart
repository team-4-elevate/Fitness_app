import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/message_entity.dart';
import 'package:hive_ce/hive.dart';

@GenerateAdapters([
  AdapterSpec<ConversationEntity>(),
  AdapterSpec<MessageEntity>(),
])
part 'hive_adapters.g.dart';

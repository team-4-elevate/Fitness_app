import 'package:fitness_app/core/Constant/app_keys.dart';
import 'package:fitness_app/core/hive/hive_registrar.g.dart';
import 'package:fitness_app/features/chat_bot/domain/entity/conversations_entity.dart';
import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@singleton
class HiveService {
  Box<ConversationEntity>? _conversationBox;

  HiveService();

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapters();
  }

  Future<Box<ConversationEntity>> get conversationBox async {
    if (_conversationBox?.isOpen == true) return _conversationBox!;
    _conversationBox = await Hive.openBox<ConversationEntity>(
      AppKeys.conversationsKey,
    );
    return _conversationBox!;
  }

  Future<void> closeConversationBox() async {
    if (_conversationBox?.isOpen == true) {
      await _conversationBox?.close();
      _conversationBox = null;
    }
  }
}

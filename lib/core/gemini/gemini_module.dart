import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:fitness_app/core/gemini/gemini_keys.dart';

@module
abstract class GeminiModule {
  @Named('geminiApiKey')
  String get apiKey => GeminiKeys.apiKey;

  @Named('geminiModelId')
  String get modelId => GeminiKeys.modelId;

  @lazySingleton
  GenerativeModel generativeModel(
    @Named('geminiApiKey') String apiKey,
    @Named('geminiModelId') String modelId,
  ) {
    return GenerativeModel(model: modelId, apiKey: apiKey);
  }
}

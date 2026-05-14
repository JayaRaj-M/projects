import '../api/ai_api.dart';

class AiService {
  Future<String> summarize(String noteContent) async {
    try {
      return await AiApi.summarize(noteContent);
    } catch (e) {
      throw Exception('Failed to summarize: $e');
    }
  }

  Future<List<String>> suggestTags(String noteContent) async {
    try {
      return await AiApi.suggestTags(noteContent);
    } catch (e) {
      throw Exception('Failed to suggest tags: $e');
    }
  }

  Future<String> improveWriting(String text) async {
    try {
      return await AiApi.improveWriting(text);
    } catch (e) {
      throw Exception('Failed to improve writing: $e');
    }
  }

  Future<String> chat(String message) async {
    try {
      return await AiApi.chat(message);
    } catch (e) {
      throw Exception('Chat failed: $e');
    }
  }
}
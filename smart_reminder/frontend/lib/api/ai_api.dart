import '../core/constants/api_constants.dart';
import 'api_service.dart';

class AiApi {
  static Future<String> summarize(String text) async {
    final data = await ApiService.post(ApiConstants.aiSummarize, {'text': text});
    return data['summary'] ?? '';
  }

  static Future<List<String>> suggestTags(String text) async {
    final data = await ApiService.post(ApiConstants.aiTags, {'text': text});
    return List<String>.from(data['tags'] ?? []);
  }

  static Future<String> improveWriting(String text) async {
    final data = await ApiService.post(ApiConstants.aiImprove, {'text': text});
    return data['improved'] ?? '';
  }

  static Future<String> chat(String message, {List<Map<String, String>>? history}) async {
    final data = await ApiService.post(ApiConstants.aiChat, {
      'message': message,
      if (history != null) 'history': history,
    });
    return data['reply'] ?? '';
  }
}
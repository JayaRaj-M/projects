enum AiResponseType { summary, tags, improvement, chat }

class AiResponseModel {
  final String id;
  final AiResponseType type;
  final String prompt;
  final String response;
  final List<String>? tags;
  final DateTime createdAt;

  AiResponseModel({
    required this.id,
    required this.type,
    required this.prompt,
    required this.response,
    this.tags,
    required this.createdAt,
  });

  factory AiResponseModel.fromMap(Map<String, dynamic> map) {
    return AiResponseModel(
      id: map['id'] ?? '',
      type: AiResponseType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => AiResponseType.chat,
      ),
      prompt: map['prompt'] ?? '',
      response: map['response'] ?? '',
      tags: map['tags'] != null ? List<String>.from(map['tags']) : null,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
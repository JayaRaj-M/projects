class NoteModel {
  final String id;
  String title;
  String content;
  List<String> tags;
  int colorIndex;
  bool isPinned;
  bool hasVoice;
  String? voicePath;
  DateTime createdAt;
  DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    this.tags = const [],
    this.colorIndex = 0,
    this.isPinned = false,
    this.hasVoice = false,
    this.voicePath,
    required this.createdAt,
    required this.updatedAt,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    List<String>? tags,
    int? colorIndex,
    bool? isPinned,
    bool? hasVoice,
    String? voicePath,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      colorIndex: colorIndex ?? this.colorIndex,
      isPinned: isPinned ?? this.isPinned,
      hasVoice: hasVoice ?? this.hasVoice,
      voicePath: voicePath ?? this.voicePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'tags': tags,
      'colorIndex': colorIndex,
      'isPinned': isPinned,
      'hasVoice': hasVoice,
      'voicePath': voicePath,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      tags: List<String>.from(map['tags'] ?? []),
      colorIndex: map['colorIndex'] ?? 0,
      isPinned: map['isPinned'] ?? false,
      hasVoice: map['hasVoice'] ?? false,
      voicePath: map['voicePath'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
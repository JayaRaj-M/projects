enum RepeatType { none, daily, weekly, monthly }

class ReminderModel {
  final String id;
  String title;
  String? description;
  DateTime dateTime;
  bool isCompleted;
  RepeatType repeatType;
  String? noteId;

  ReminderModel({
    required this.id,
    required this.title,
    this.description,
    required this.dateTime,
    this.isCompleted = false,
    this.repeatType = RepeatType.none,
    this.noteId,
  });

  ReminderModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
    bool? isCompleted,
    RepeatType? repeatType,
    String? noteId,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isCompleted: isCompleted ?? this.isCompleted,
      repeatType: repeatType ?? this.repeatType,
      noteId: noteId ?? this.noteId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'isCompleted': isCompleted,
      'repeatType': repeatType.index,
      'noteId': noteId,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dateTime: DateTime.parse(map['dateTime']),
      isCompleted: map['isCompleted'] ?? false,
      repeatType: RepeatType.values[map['repeatType'] ?? 0],
      noteId: map['noteId'],
    );
  }
}
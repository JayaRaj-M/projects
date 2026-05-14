import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note_model.dart';
import '../models/reminder_model.dart';

class LocalDb {
  static const String _notesKey = 'notes';
  static const String _remindersKey = 'reminders';

  // Notes
  static Future<List<NoteModel>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_notesKey);
    if (jsonStr == null) return [];
    final List list = jsonDecode(jsonStr);
    return list.map((e) => NoteModel.fromMap(e)).toList();
  }

  static Future<void> saveNotes(List<NoteModel> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(notes.map((n) => n.toMap()).toList());
    await prefs.setString(_notesKey, json);
  }

  // Reminders
  static Future<List<ReminderModel>> getReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_remindersKey);
    if (jsonStr == null) return [];
    final List list = jsonDecode(jsonStr);
    return list.map((e) => ReminderModel.fromMap(e)).toList();
  }

  static Future<void> saveReminders(List<ReminderModel> reminders) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(reminders.map((r) => r.toMap()).toList());
    await prefs.setString(_remindersKey, json);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
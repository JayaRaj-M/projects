import 'package:flutter/material.dart';
import '../models/reminder_model.dart';

class ReminderProvider extends ChangeNotifier {
  final List<ReminderModel> _reminders = [];

  List<ReminderModel> get reminders => List.unmodifiable(_reminders);

  List<ReminderModel> get pendingReminders => _reminders.where((r) => !r.isCompleted).toList();

  void addReminder(ReminderModel reminder) {
    _reminders.add(reminder);
    notifyListeners();
  }

  void updateReminder(ReminderModel updated) {
    final index = _reminders.indexWhere((r) => r.id == updated.id);
    if (index != -1) {
      _reminders[index] = updated;
      notifyListeners();
    }
  }

  void deleteReminder(String id) {
    _reminders.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  void toggleReminder(String id) {
    final index = _reminders.indexWhere((r) => r.id == id);
    if (index != -1) {
      _reminders[index] = _reminders[index].copyWith(isCompleted: !_reminders[index].isCompleted);
      notifyListeners();
    }
  }
}
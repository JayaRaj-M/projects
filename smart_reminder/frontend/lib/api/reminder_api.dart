import '../core/constants/api_constants.dart';
import '../models/reminder_model.dart';
import 'api_service.dart';

class ReminderApi {
  static Future<List<ReminderModel>> fetchAll() async {
    final data = await ApiService.get(ApiConstants.reminders);
    final List list = data['reminders'] ?? [];
    return list.map((e) => ReminderModel.fromMap(e)).toList();
  }

  static Future<ReminderModel> create(ReminderModel reminder) async {
    final data = await ApiService.post(ApiConstants.reminders, reminder.toMap());
    return ReminderModel.fromMap(data['reminder']);
  }

  static Future<ReminderModel> update(ReminderModel reminder) async {
    final data = await ApiService.put(
      ApiConstants.reminderById.replaceAll('{id}', reminder.id),
      reminder.toMap(),
    );
    return ReminderModel.fromMap(data['reminder']);
  }

  static Future<void> delete(String id) async {
    await ApiService.delete(ApiConstants.reminderById.replaceAll('{id}', id));
  }
}
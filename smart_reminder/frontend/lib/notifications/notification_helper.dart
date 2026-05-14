import '../models/reminder_model.dart';
import 'notification_service.dart';

class NotificationHelper {
  static Future<void> scheduleReminder(ReminderModel reminder) async {
    await NotificationService.show(
      id: reminder.id.hashCode,
      title: reminder.title,
      body: reminder.description ?? 'You have a reminder!',
    );
  }

  static Future<void> cancelReminder(String reminderId) async {
    await NotificationService.cancel(reminderId.hashCode);
  }
}
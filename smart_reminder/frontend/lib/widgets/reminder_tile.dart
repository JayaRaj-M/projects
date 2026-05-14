import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/date_formatter.dart';
import '../models/reminder_model.dart';

class ReminderTile extends StatelessWidget {
  final ReminderModel reminder;
  final Function(String) onToggle;
  final Function(String) onDelete;

  const ReminderTile({super.key, required this.reminder, required this.onToggle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(reminder.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(reminder.id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Checkbox(
              value: reminder.isCompleted,
              onChanged: (_) => onToggle(reminder.id),
              shape: const CircleBorder(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      decoration: reminder.isCompleted ? TextDecoration.lineThrough : null,
                      color: reminder.isCompleted ? AppColors.textSecondary : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.alarm, size: 12, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        DateFormatter.formatForReminder(reminder.dateTime),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
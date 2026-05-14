import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/reminder_provider.dart';
import '../../widgets/reminder_tile.dart';
import '../../widgets/empty_state_widget.dart';
import '../../models/reminder_model.dart';
import '../../core/utils/helpers.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  void _addReminder(BuildContext context) async {
    final titleController = TextEditingController();
    DateTime selectedDate = DateTime.now().add(const Duration(hours: 1));

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.newReminder, style: Theme.of(ctx).textTheme.headlineSmall),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text(AppStrings.save),
              onPressed: () {
                if (titleController.text.trim().isNotEmpty) {
                  context.read<ReminderProvider>().addReminder(ReminderModel(
                    id: Helpers.generateId(),
                    title: titleController.text.trim(),
                    dateTime: selectedDate,
                  ));
                  Navigator.pop(ctx);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reminders)),
      body: Consumer<ReminderProvider>(
        builder: (context, provider, _) {
          if (provider.reminders.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.alarm_off_rounded,
              title: AppStrings.noReminders,
              subtitle: AppStrings.noRemindersSubtitle,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: provider.reminders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, index) => ReminderTile(
              reminder: provider.reminders[index],
              onToggle: (id) => provider.toggleReminder(id),
              onDelete: (id) => provider.deleteReminder(id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addReminder(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
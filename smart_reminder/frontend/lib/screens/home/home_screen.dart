import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/note_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/note_card.dart';
import '../../widgets/empty_state_widget.dart';
import '../../widgets/floating_create_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
          ),
        ],
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, _) {
          if (noteProvider.notes.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.note_alt_outlined,
              title: AppStrings.noNotes,
              subtitle: AppStrings.noNotesSubtitle,
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: noteProvider.notes.length,
            itemBuilder: (context, index) {
              final note = noteProvider.notes[index];
              return NoteCard(
                note: note,
                onTap: () => Navigator.pushNamed(context, AppRoutes.noteEditor, arguments: note),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingCreateButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.noteEditor),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
          if (index == 1) Navigator.pushNamed(context, AppRoutes.reminder);
          if (index == 2) Navigator.pushNamed(context, AppRoutes.aiAssistant);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: AppStrings.home),
          NavigationDestination(icon: Icon(Icons.alarm_outlined), selectedIcon: Icon(Icons.alarm), label: AppStrings.reminders),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: AppStrings.aiAssistant),
        ],
      ),
    );
  }
}
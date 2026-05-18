// lib/screens/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/note_provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/note_card.dart';
import 'note_editor/note_editor_screen.dart';
import 'reminder/reminder_screen.dart';
import 'settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchCtrl = TextEditingController();
  late AnimationController _fabAnim;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fabAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use dynamic to avoid static type error if method name differs
      (context.read<NoteProvider>() as dynamic).loadNotes();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _fabAnim.dispose();
    super.dispose();
  }

  void _openNote([String? noteId]) async {
    final provider = context.read<NoteProvider>();
    final note = noteId != null
        ? provider.notes.firstWhere((note) => note.id == noteId)
        : null;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const NoteEditorScreen(),
        settings: RouteSettings(arguments: note),
      ),
    );
    if (mounted) {
      (context.read<NoteProvider>() as dynamic).loadNotes();
    }
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 1:
        return const ReminderScreen();
      case 2:
        return const SettingsScreen();
      default:
        return _NotesView(onNoteOpen: _openNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _buildBody(),
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () => _openNote(null),
              child: const Icon(Icons.add_rounded, size: 28),
            )
          : null,
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        onTap: (idx) => setState(() => _currentIndex = idx),
      ),
    );
  }
}

class _NotesView extends StatefulWidget {
  final void Function([String? id]) onNoteOpen;

  const _NotesView({required this.onNoteOpen});

  @override
  State<_NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<_NotesView> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';
  String _viewMode = AppConstants.viewGrid;
  String _sortBy = AppConstants.sortByDate;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List _applySort(List notes) {
    final sorted = [...notes];
    if (_sortBy == AppConstants.sortByTitle) {
      sorted.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    } else {
      sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    }

    final pinned = sorted.where((n) => n.isPinned).toList();
    final unpinned = sorted.where((n) => !n.isPinned).toList();
    return [...pinned, ...unpinned];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, _) {
        final filteredNotes = _searchQuery.isEmpty
            ? provider.notes
            : provider.search(_searchQuery);
        final sortedNotes = _applySort(filteredNotes);
        final pinnedNotes = sortedNotes.where((n) => n.isPinned).toList();
        final unpinnedNotes = sortedNotes.where((n) => !n.isPinned).toList();

        return CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Notes',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    foreground: Paint()
                                      ..shader = const LinearGradient(
                                        colors: [
                                          AppColors.primary,
                                          AppColors.primaryLight,
                                        ],
                                      ).createShader(
                                          const Rect.fromLTWH(0, 0, 200, 40)),
                                  ),
                            ),
                            Text(
                              '${filteredNotes.length} notes',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        const Spacer(),
                        _ViewToggle(
                          viewMode: _viewMode,
                          onToggle: (mode) => setState(() => _viewMode = mode),
                        ),
                        const SizedBox(width: 8),
                        _SortButton(
                          sortBy: _sortBy,
                          onSelect: (value) => setState(() => _sortBy = value),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Search bar
                    _SearchBar(
                      controller: _searchCtrl,
                      onChanged: (q) {
                        setState(() => _searchQuery = q);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            if (filteredNotes.isEmpty)
              SliverToBoxAdapter(
                child: _EmptyState(
                  hasSearch: _searchQuery.isNotEmpty,
                ),
              )
            else ...[
              if (pinnedNotes.isNotEmpty) ...[
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: _SectionHeader(
                      icon: Icons.push_pin_rounded,
                      label: 'Pinned',
                      color: AppColors.warning,
                    ),
                  ),
                ),
                _buildNoteGrid(
                  context,
                  pinnedNotes,
                  _viewMode,
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
              if (unpinnedNotes.isNotEmpty) ...[
                if (pinnedNotes.isNotEmpty)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: _SectionHeader(
                        icon: Icons.notes_rounded,
                        label: 'All Notes',
                      ),
                    ),
                  ),
                _buildNoteGrid(
                  context,
                  unpinnedNotes,
                  _viewMode,
                ),
              ],
            ],

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        );
      },
    );
  }

  Widget _buildNoteGrid(
    BuildContext context,
    List notes,
    String viewMode,
  ) {
    if (viewMode == AppConstants.viewList) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            child: NoteListTile(
              note: notes[i],
              onTap: () => widget.onNoteOpen(notes[i].id),
              onLongPress: () => _showNoteOptions(context, notes[i]),
            ),
          ),
          childCount: notes.length,
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childCount: notes.length,
        itemBuilder: (ctx, i) => NoteCard(
          note: notes[i],
          onTap: () => widget.onNoteOpen(notes[i].id),
          onLongPress: () => _showNoteOptions(context, notes[i]),
        ),
      ),
    );
  }

  void _showNoteOptions(BuildContext context, dynamic note) {
    final provider = context.read<NoteProvider>();

    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.textMuted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            _BottomSheetOption(
              icon: note.isPinned
                  ? Icons.push_pin_outlined
                  : Icons.push_pin_rounded,
              label: note.isPinned ? 'Unpin' : 'Pin note',
              onTap: () {
                provider.togglePin(note.id);
                Navigator.pop(ctx);
              },
            ),
            _BottomSheetOption(
              icon: Icons.archive_outlined,
              label: 'Archive',
              onTap: () {
                provider.toggleArchive(note.id);
                Navigator.pop(ctx);
              },
            ),
            _BottomSheetOption(
              icon: Icons.delete_outline_rounded,
              label: 'Delete',
              color: AppColors.error,
              onTap: () {
                provider.deleteNote(note.id);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontFamily: 'DMSans',
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
        decoration: const InputDecoration(
          hintText: 'Search notes...',
          hintStyle: TextStyle(color: AppColors.textMuted),
          prefixIcon:
              Icon(Icons.search_rounded, color: AppColors.textMuted, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _ViewToggle extends StatelessWidget {
  final String viewMode;
  final ValueChanged<String> onToggle;

  const _ViewToggle({required this.viewMode, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(
        viewMode == AppConstants.viewGrid
            ? AppConstants.viewList
            : AppConstants.viewGrid,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(
          viewMode == AppConstants.viewGrid
              ? Icons.view_list_rounded
              : Icons.grid_view_rounded,
          size: 20,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  final String sortBy;
  final ValueChanged<String> onSelect;

  const _SortButton({required this.sortBy, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.textMuted,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: Text(
                    'Sort Notes',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                _BottomSheetOption(
                  icon: Icons.schedule_rounded,
                  label: 'By Date',
                  isSelected: sortBy == AppConstants.sortByDate,
                  onTap: () {
                    onSelect(AppConstants.sortByDate);
                    Navigator.pop(context);
                  },
                ),
                _BottomSheetOption(
                  icon: Icons.sort_by_alpha_rounded,
                  label: 'By Title',
                  isSelected: sortBy == AppConstants.sortByTitle,
                  onTap: () {
                    onSelect(AppConstants.sortByTitle);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: const Icon(
          Icons.sort_rounded,
          size: 20,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.label,
    this.color = AppColors.textMuted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontFamily: 'DMSans',
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: color,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool hasSearch;

  const _EmptyState({this.hasSearch = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          Icon(
            hasSearch ? Icons.search_off_rounded : Icons.note_add_outlined,
            size: 64,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            hasSearch ? 'No results found' : 'No notes yet',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            hasSearch
                ? 'Try a different search term'
                : 'Tap the + button to create your first note',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BottomSheetOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final bool isSelected;

  const _BottomSheetOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? (isSelected ? AppColors.primary : AppColors.textPrimary);
    return ListTile(
      leading: Icon(icon, color: c, size: 22),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 15,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: c,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_rounded, color: AppColors.primary, size: 18)
          : null,
      onTap: onTap,
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notes_rounded),
            activeIcon: Icon(Icons.notes_rounded),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications_rounded),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

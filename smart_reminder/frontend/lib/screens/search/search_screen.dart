import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/note_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/note_card.dart';
import '../../widgets/empty_state_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: AppStrings.searchHint,
            border: InputBorder.none,
            filled: false,
          ),
          onChanged: (val) => setState(() => _query = val.trim()),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                setState(() => _query = '');
              },
            ),
        ],
      ),
      body: Consumer<NoteProvider>(
        builder: (context, provider, _) {
          final results = _query.isEmpty
              ? provider.notes
              : provider.notes.where((n) =>
                  n.title.toLowerCase().contains(_query.toLowerCase()) ||
                  n.content.toLowerCase().contains(_query.toLowerCase())).toList();

          if (results.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.search_off_rounded,
              title: AppStrings.noResults,
              subtitle: AppStrings.noResultsSubtitle,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: results.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: NoteCard(
                note: results[index],
                onTap: () => Navigator.pushNamed(context, AppRoutes.noteEditor, arguments: results[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
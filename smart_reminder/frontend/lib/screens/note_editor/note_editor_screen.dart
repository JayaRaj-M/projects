import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/helpers.dart';
import '../../models/note_model.dart';
import '../../providers/note_provider.dart';
import '../../routes/app_routes.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  NoteModel? _existingNote;
  int _colorIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final note = ModalRoute.of(context)?.settings.arguments as NoteModel?;
    if (note != null && _existingNote == null) {
      _existingNote = note;
      _titleController.text = note.title;
      _contentController.text = note.content;
      _colorIndex = note.colorIndex;
    }
  }

  void _save() {
    final provider = context.read<NoteProvider>();
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
      return;
    }
    if (_existingNote != null) {
      provider.updateNote(_existingNote!.copyWith(
        title: title.isEmpty ? 'Untitled' : title,
        content: content,
        colorIndex: _colorIndex,
        updatedAt: DateTime.now(),
      ));
    } else {
      provider.addNote(NoteModel(
        id: Helpers.generateId(),
        title: title.isEmpty ? 'Untitled' : title,
        content: content,
        colorIndex: _colorIndex,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
    }
    Navigator.pop(context);
  }

  void _delete() async {
    final confirm = await Helpers.showConfirmDialog(context, title: 'Delete Note', message: 'Are you sure you want to delete this note?');
    if (confirm == true && _existingNote != null) {
      context.read<NoteProvider>().deleteNote(_existingNote!.id);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.noteColors[_colorIndex],
      appBar: AppBar(
        backgroundColor: AppColors.noteColors[_colorIndex],
        elevation: 0,
        actions: [
          if (_existingNote != null)
            IconButton(icon: const Icon(Icons.delete_outline), onPressed: _delete),
          IconButton(
            icon: const Icon(Icons.mic_none_rounded),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.voice),
          ),
          TextButton(onPressed: _save, child: const Text(AppStrings.save)),
        ],
      ),
      body: Column(
        children: [
          // Color picker
          SizedBox(
            height: 40,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: AppColors.noteColors.length,
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => setState(() => _colorIndex = i),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.noteColors[i],
                    shape: BoxShape.circle,
                    border: _colorIndex == i ? Border.all(color: AppColors.primary, width: 2) : null,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    style: Theme.of(context).textTheme.headlineSmall,
                    decoration: const InputDecoration(
                      hintText: AppStrings.titleHint,
                      border: InputBorder.none,
                      filled: false,
                    ),
                    maxLines: 1,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                        hintText: AppStrings.contentHint,
                        border: InputBorder.none,
                        filled: false,
                      ),
                      maxLines: null,
                      expands: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
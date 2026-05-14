import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NoteProvider extends ChangeNotifier {
  final List<NoteModel> _notes = [];

  List<NoteModel> get notes {
    final pinned = _notes.where((n) => n.isPinned).toList();
    final unpinned = _notes.where((n) => !n.isPinned).toList();
    return [...pinned, ...unpinned];
  }

  void addNote(NoteModel note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  void updateNote(NoteModel updated) {
    final index = _notes.indexWhere((n) => n.id == updated.id);
    if (index != -1) {
      _notes[index] = updated;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void togglePin(String id) {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(isPinned: !_notes[index].isPinned);
      notifyListeners();
    }
  }

  List<NoteModel> search(String query) {
    if (query.isEmpty) return notes;
    return notes.where((n) =>
        n.title.toLowerCase().contains(query.toLowerCase()) ||
        n.content.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
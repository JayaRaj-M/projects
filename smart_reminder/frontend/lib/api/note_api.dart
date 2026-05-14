import '../core/constants/api_constants.dart';
import '../models/note_model.dart';
import 'api_service.dart';

class NoteApi {
  static Future<List<NoteModel>> fetchAll() async {
    final data = await ApiService.get(ApiConstants.notes);
    final List list = data['notes'] ?? [];
    return list.map((e) => NoteModel.fromMap(e)).toList();
  }

  static Future<NoteModel> create(NoteModel note) async {
    final data = await ApiService.post(ApiConstants.notes, note.toMap());
    return NoteModel.fromMap(data['note']);
  }

  static Future<NoteModel> update(NoteModel note) async {
    final data = await ApiService.put(
      ApiConstants.noteById.replaceAll('{id}', note.id),
      note.toMap(),
    );
    return NoteModel.fromMap(data['note']);
  }

  static Future<void> delete(String id) async {
    await ApiService.delete(ApiConstants.noteById.replaceAll('{id}', id));
  }
}
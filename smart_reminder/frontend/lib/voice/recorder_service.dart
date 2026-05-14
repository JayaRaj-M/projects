// Stub — replace with record package implementation
class RecorderService {
  bool _isRecording = false;
  bool get isRecording => _isRecording;

  Future<void> start() async {
    _isRecording = true;
    // TODO: implement with record package
  }

  Future<String?> stop() async {
    _isRecording = false;
    // TODO: return path to recorded file
    return null;
  }

  Future<void> dispose() async {}
}
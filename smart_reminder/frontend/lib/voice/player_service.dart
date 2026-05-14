// Stub — replace with just_audio or audioplayers package
class PlayerService {
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  Future<void> play(String filePath) async {
    _isPlaying = true;
    // TODO: implement with audioplayers
  }

  Future<void> pause() async {
    _isPlaying = false;
  }

  Future<void> stop() async {
    _isPlaying = false;
  }

  Future<void> dispose() async {}
}
// Stub — replace with speech_to_text package
class SpeechToTextService {
  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;

  Future<void> init() async {
    // TODO: initialize speech_to_text
    _isAvailable = true;
  }

  Future<void> listen({required Function(String) onResult}) async {
    // TODO: start listening and call onResult with transcribed text
  }

  Future<void> stop() async {
    // TODO: stop listening
  }
}

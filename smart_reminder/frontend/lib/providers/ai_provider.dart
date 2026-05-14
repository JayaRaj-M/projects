import 'package:flutter/material.dart';
import '../widgets/ai_suggestion_card.dart';

class AiProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String text) async {
    _messages.add(ChatMessage(text: text, isUser: true, time: DateTime.now()));
    _isLoading = true;
    notifyListeners();

    // Simulate AI response — replace with real API call
    await Future.delayed(const Duration(seconds: 1));
    _messages.add(ChatMessage(
      text: 'I received your message: "$text". Connect me to your AI API to get real responses!',
      isUser: false,
      time: DateTime.now(),
    ));
    _isLoading = false;
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
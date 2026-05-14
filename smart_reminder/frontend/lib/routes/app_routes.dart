import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/note_editor/note_editor_screen.dart';
import '../screens/reminder/reminder_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/voice/voice_record_screen.dart';
import '../screens/ai_assistant/ai_assistant_screen.dart';
import '../screens/settings/settings_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String noteEditor = '/note-editor';
  static const String reminder = '/reminder';
  static const String search = '/search';
  static const String voice = '/voice';
  static const String aiAssistant = '/ai-assistant';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _route(const SplashScreen(), settings);
      case home:
        return _route(const HomeScreen(), settings);
      case noteEditor:
        return _route(const NoteEditorScreen(), settings);
      case reminder:
        return _route(const ReminderScreen(), settings);
      case search:
        return _route(const SearchScreen(), settings);
      case voice:
        return _route(const VoiceRecordScreen(), settings);
      case aiAssistant:
        return _route(const AiAssistantScreen(), settings);
      case AppRoutes.settings:
        return _route(const SettingsScreen(), settings);
      default:
        return _route(const HomeScreen(), settings);
    }
  }

  static PageRouteBuilder _route(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}
class ApiConstants {
  static const String baseUrl = 'https://api.yourapp.com/v1';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';

  // Notes
  static const String notes = '/notes';
  static const String noteById = '/notes/{id}';

  // Reminders
  static const String reminders = '/reminders';
  static const String reminderById = '/reminders/{id}';

  // AI
  static const String aiSummarize = '/ai/summarize';
  static const String aiTags = '/ai/tags';
  static const String aiImprove = '/ai/improve';
  static const String aiChat = '/ai/chat';

  // Timeouts
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Headers
  static const String contentType = 'application/json';
  static const String authHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer ';
}
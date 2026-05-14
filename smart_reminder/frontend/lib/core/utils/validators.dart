class Validators {
  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? minLength(String? value, int min) {
    if (value == null || value.length < min) {
      return 'Minimum $min characters required';
    }
    return null;
  }

  static String? maxLength(String? value, int max) {
    if (value != null && value.length > max) {
      return 'Maximum $max characters allowed';
    }
    return null;
  }

  static String? noteTitle(String? value) {
    return required(value, field: 'Title');
  }

  static String? reminderTitle(String? value) {
    return required(value, field: 'Reminder title');
  }
}
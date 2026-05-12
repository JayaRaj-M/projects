class Validators {
  static String? validateEmail(String? value) => value != null && value.contains('@') ? null : 'Invalid email';
}
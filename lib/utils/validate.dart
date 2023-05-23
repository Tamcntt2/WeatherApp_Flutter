class Validate {
  static bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static bool validatePassword(String password) {
    return true;
  }

  static bool confirmPassword(String password1, String password2) {
    return password1 == password2;
  }
}

RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

class Validators {
  // ! Email validator
  static String? emailValidator(String value) {
    if (!emailRegex.hasMatch(value)) {
      return "Email tidak valid";
    }

    if (value.isEmpty) {
      return "Masih kosong...";
    }

    return null;
  }

  // ! Username validator
  static String? usernameValidator(String value) {
    if (value.isEmpty) {
      return "Masih kosong...";
    }

    if (value.length < 5) {
      return "Panjang username minimal 5";
    }

    return null;
  }

  // ! Password validator
  static String? passwordValidator(String value) {
    if (value.isEmpty) {
      return "Masih kosong...";
    }

    if (value.length < 8) {
      return "Panjang password minimal 8";
    }

    return null;
  }
}

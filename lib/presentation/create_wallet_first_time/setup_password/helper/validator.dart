class Validator {
  static bool isValidPassword(String value) {
    if (value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

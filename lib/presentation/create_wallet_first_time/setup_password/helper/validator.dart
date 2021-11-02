class Validator {
  static bool isValidPassword(String value) {
    if(value.length < 8 && value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

}
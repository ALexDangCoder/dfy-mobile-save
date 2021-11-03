class Validator {
  static bool isValidPassword(String value) {
    if(value.length < 8 || value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static bool validateStructure(String value){
    const String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}

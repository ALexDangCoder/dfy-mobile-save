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

  static bool validateAddress(String value) {
    const String pattern = r'^[a-zA-Z0-9]{1,40}+$';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool validateNumber(String value) {
    const String pattern = r'(^\-?\d*\.?\d*)';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool validateNotNull(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

class Validator {
  static bool isValidPassword(String value) {
    if(value.length < 8 || value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static bool validateStructure(String value){
    const String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[.!@#\$&*~]).{8,}$';
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

  //this extension will handle number with e
  static String toExact(double input) {
    double value = double.parse(input.toStringAsFixed(5));
    var sign = '';
    if (value < 0) {
      value = -value;
      sign = '-';
    }
    final string = value.toString();
    final e = string.lastIndexOf('e');
    if (e < 0) return '$sign$string';
    assert(string.indexOf('.') == 1);
    final offset = int.parse(
      string.substring(e + (string.startsWith('-', e + 1) ? 1 : 2)),
    );
    final digits = string.substring(0, 1) + string.substring(2, e);
    if (offset < 0) {
      return "${sign}0.${"0" * ~offset}$digits";
    }
    if (offset > 0) {
      if (offset >= digits.length) {
        return sign + digits.padRight(offset + 1, '0');
      }
      return '$sign${digits.substring(0, offset + 1)}'
          '.${digits.substring(offset + 1)}';
    }
    return digits;
  }
}

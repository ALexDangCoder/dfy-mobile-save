import 'package:intl/intl.dart';

bool isStrEmpty(String? str) {
  return str == null || str.trim().isEmpty;
}

bool isStrNotEmpty(String? str) {
  return str != null && str.isNotEmpty;
}

String formatCurrency(dynamic amount, String symbol) {
  dynamic price;
  if (amount is String) {
    price = double.tryParse(amount) ?? 0;
  } else {
    price = amount;
  }
  final formatter = NumberFormat('###,###.##');
  final String mAmount = formatter.format(price);
  return mAmount + symbol;
}

String customCurrency(
    {required dynamic amount, String type = '', int digit = 1}) {
  dynamic price;
  String _format = '###,###.';
  if (amount is String) {
    price = double.tryParse(amount) ?? 0;
  } else {
    price = amount;
  }
  for (var i = 0; i < digit; i++) {
    _format = '$_format#';
  }

  final formatter = NumberFormat(_format);
  final String mAmount = formatter.format(price);
  return '$mAmount $type';
}

extension FormatString on String {
  String get formatAddress {
    String a = '';
    try {
      a = '${substring(0, 12)}...${substring(
        length - 12,
        length,
      )}';
    } catch (e) {
      a = this;
    }
    return a;
  }
}

extension FormatDateToString on DateTime {
  String get stringFromDateTime {
    String result = '';
    try {
      result = DateFormat('HH:mm dd/MM/yyyy').format(this);
    } catch (e) {
      result = toString();
    }
    return result;
  }
}

extension FomatNumber on int {
  String get stringIntFormat {
    String result = '';
    try {
      result = NumberFormat('#,###').format(this);
    } catch (e) {
      result = toString();
    }
    return result;
  }
}

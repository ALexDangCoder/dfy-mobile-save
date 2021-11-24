import 'package:intl/intl.dart';

final formatValue = NumberFormat('###,###,###.###', 'en_US');
extension StringHandle on String{
  String handleString() {
    final String result = '${substring(0,10)}...${substring(length - 10)}';
    return result;
  }
}

extension StringMoneyFormat on String{
  String formatMoney(double money) {
    final String result = formatValue.format(money);
    return result;
  }
}


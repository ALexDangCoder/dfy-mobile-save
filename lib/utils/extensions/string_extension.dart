import 'package:html/parser.dart';
import 'package:intl/intl.dart';
final formatValue = NumberFormat('###,###,###.###', 'en_US');

extension StringHandle on String {
  String handleString() {
    final String result =
        '${substring(0, 7)}...${substring(length - 10, length)}';
    return result;
  }
}

extension StringMoneyFormat on String {
  String formatMoney(double money) {
    final String result = formatValue.format(money);
    return result;
  }
}

extension FormatAddress on String {
  String formatAddressWallet() {
    final String result = '${substring(0, 5)}...${substring(
      length - 4, length,)}';
    return result;
  }
}


extension StringParse on String {
  String parseHtml() {
    final document = parse(this);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';
    return parsedString;
  }
}

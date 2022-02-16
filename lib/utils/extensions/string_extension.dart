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

  String formatDateTimeMy(int date) {
    var millis = date;
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    String d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt);
    return d24;
  }
}

extension FormatAddress on String {
  String formatAddressWallet() {
    final String result = '${substring(0, 5)}...${substring(
      length - 4,
      length,
    )}';
    return result;
  }
}

extension FormatAddressFire on String {
  String formatAddressActivityFire() {
    final String result = '${substring(0, 5)}...${substring(
      length - 5,
      length,
    )}';
    return result;
  }
}

extension FormatAddressConfirm on String {
  String formatAddressWalletConfirm() {
    final String result = '${substring(0, 10)}...${substring(
      length - 9,
      length,
    )}';
    return result;
  }

  String formatAddressDialog() {
    final String result = '${substring(0, 5)}...${substring(
      length - 4,
      length,
    )}';
    return result;
  }

  String formatStringTooLong() {
    final String result = '${substring(0, 12)} ...';
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

  int parseToInt(){
    int vl = -1;
    try {
      vl = int.parse(this);
    } catch (_){}
    return vl;
  }
}

extension DiacriticsAwareString on String {
  bool checkEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}")
        .hasMatch(this);
  }

  bool checkSdt() {
    return RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(this);
  }

  String stripHtmlIfNeeded() {
    return replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }
}

extension VietNameseParse on String {
  String vietNameseParse() {
    var result = this;

    const _vietnamese = 'aAeEoOuUiIdDyY';
    final _vietnameseRegex = <RegExp>[
      RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
      RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
      RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
      RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
      RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
      RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
      RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
      RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
      RegExp(r'ì|í|ị|ỉ|ĩ'),
      RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
      RegExp(r'đ'),
      RegExp(r'Đ'),
      RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
      RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
    ];

    for (var i = 0; i < _vietnamese.length; ++i) {
      result = result.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
    }
    return result;
  }
}

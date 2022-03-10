import 'package:intl/intl.dart';

extension formatInt on int {
  String formatDateTimeMy(int date) {
    var millis = date;
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    String d24 = DateFormat('HH:mm - dd/MM/yyyy').format(dt);
    return d24;
  }

  String formatHourMy(int date) {
    var millis = date;
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    String d24 = DateFormat('HH:mm').format(dt);
    return d24;
  }
}

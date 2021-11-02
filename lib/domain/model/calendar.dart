class CalendarModel {
  CalendarModel({this.id, this.title});

  int? id;
  String? title;
}

final currentDateTime = DateTime.now();
final firstDay = DateTime(
    currentDateTime.year, currentDateTime.month - 3, currentDateTime.day);
final lastDay = DateTime(
    currentDateTime.year, currentDateTime.month + 3, currentDateTime.day);

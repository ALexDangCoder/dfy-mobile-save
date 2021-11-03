import 'package:Dfy/domain/model/calendar.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarChoose extends StatelessWidget {
  DateTime rangeStart;
  DateTime rangeEnd;
  DateTime selected;
  DateTime focusedDay;

  // List<CalendarModel> events = [];

  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final Function(DateTime? start, DateTime? end, DateTime focusedDay)
      onRangeSelected;

  CalendarChoose({
    Key? key,
    required this.selected,
    required this.rangeStart,
    required this.rangeEnd,
    required this.focusedDay,
    required this.onDaySelected,
    required this.onRangeSelected,
  }) : super(key: key);

  List<CalendarModel> _getEventsForDay(DateTime day) {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xCC282D35),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TableCalendar<CalendarModel>(
        firstDay: firstDay,
        lastDay: lastDay,
        focusedDay: focusedDay,
        availableCalendarFormats: const {
          CalendarFormat.month: CALENDAR_TYPE_MONTH,
        },
        selectedDayPredicate: (day) => isSameDay(selected, day),
        rangeStartDay: rangeStart,
        rangeEndDay: rangeEnd,
        headerStyle: const HeaderStyle(
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Colors.white,
          ),
        ),
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekendStyle: TextStyle(color: Color(0xFFAD1B1B)),
          weekdayStyle: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        calendarStyle: const CalendarStyle(
            todayTextStyle: TextStyle(color: Color(0xFFFFFFFF)),
            //text other day
            outsideTextStyle: TextStyle(color: Color(0xFF797979)),
            //text holiday
            weekendTextStyle: TextStyle(color: Color(0xFFAD1B1B)),
            //color select day
            selectedDecoration: BoxDecoration(
              color: Color(0xFFC82F81),
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Color(0xFF1294F2),
              shape: BoxShape.circle,
            ),
            //normal day
            defaultTextStyle: TextStyle(color: Color(0xFFFFFFFF)),),
        onDaySelected: (selectedDay, focusedDay) {
          onDaySelected(selectedDay, focusedDay);
        },
        onRangeSelected: (start, end, focusedDay) {
          onRangeSelected(start, end, focusedDay);
        },
        onFormatChanged: (format) {},
        onPageChanged: (focusedDay) {
          this.focusedDay = focusedDay;
        },
      ),
    );
  }
}

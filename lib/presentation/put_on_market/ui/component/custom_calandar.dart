import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _selectedDay = DateTime(2022, 01, 12);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 700),
                width: MediaQuery.of(context).size.width - 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  color: colorSkeleton,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TableCalendar(
                        //style
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                        ),
                        calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(color: Colors.red),
                          todayDecoration:
                              BoxDecoration(color: Colors.transparent),
                          holidayTextStyle: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w500,
                          ),
                          weekendTextStyle: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w500,
                          ),
                          defaultTextStyle: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w500,
                          ),
                          todayTextStyle: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w500,
                          ),
                          selectedTextStyle: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w500,
                          ),
                        ),

                        //attribute
                        locale: Localizations.localeOf(context).languageCode,
                        focusedDay: _selectedDay,
                        firstDay: DateTime(DateTime.now().year - 10),
                        lastDay: DateTime(DateTime.now().year + 10),

                        //action

                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      height: 1,
                      color:
                          AppTheme.getInstance().whiteColor().withOpacity(0.1),
                    ),
                    SizedBox(
                      height: 64,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(
                                  S.current.cancel,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().whiteColor(),
                                    20,
                                    FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            color: AppTheme.getInstance()
                                .whiteColor()
                                .withOpacity(0.1),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(
                                  S.current.ok,
                                  style: textNormalCustom(
                                    fillYellowColor,
                                    20,
                                    FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

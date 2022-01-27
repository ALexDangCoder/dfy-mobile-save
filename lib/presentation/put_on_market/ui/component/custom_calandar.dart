import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime? selectDate;
  const CustomCalendar({Key? key, this.selectDate}) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _selectedDay;

  @override
  void initState() {
    _selectedDay = widget.selectDate ?? DateTime.now();
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
                        daysOfWeekHeight: 32,
                        daysOfWeekStyle:  DaysOfWeekStyle(
                          weekdayStyle: textNormalCustom(
                            AppTheme.getInstance().getPurpleColor(),
                            16,
                            FontWeight.w400,
                          ),
                          weekendStyle: textNormalCustom(
                            AppTheme.getInstance().getPurpleColor(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        //style
                        headerStyle: HeaderStyle(
                          titleTextStyle: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            24,
                            FontWeight.w700,
                          ),
                          titleCentered: true,
                          formatButtonVisible: false,
                          leftChevronIcon: SvgPicture.asset(
                            ImageAssets.ic_btn_back_svg,
                            color: AppTheme.getInstance().whiteColor(),
                            height: 12,
                          ),
                          rightChevronIcon: SvgPicture.asset(
                            ImageAssets.ic_btn_next_svg,
                            height: 12,
                            color: AppTheme.getInstance().whiteColor(),
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(
                          todayBuilder: (context, date, __) {
                            return Stack(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  height: 17,
                                  child: Center(
                                    child: Text(
                                      'today',
                                      textAlign: TextAlign.center,
                                      style: textNormalCustom(
                                        AppTheme.getInstance().yellowColor(),
                                        10,
                                        FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    date.day.toString(),
                                    style: textNormalCustom(
                                      AppTheme.getInstance().whiteColor(),
                                      16,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.getInstance().yellowColor(),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.getInstance()
                                    .yellowColor()
                                    .withOpacity(0.5),
                                offset: const Offset(0, 5),
                                blurRadius: 5,
                                //spreadRadius: _spreadRadius,
                              )
                            ],
                          ),

                          cellMargin:
                          const EdgeInsets.symmetric(horizontal: 2),
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
                            FontWeight.w700,
                          ),

                        ),

                        //attribute
                        locale: Localizations.localeOf(context).languageCode,
                        focusedDay: _selectedDay,
                        firstDay: DateTime(DateTime.now().year - 10),
                        lastDay: DateTime(
                          DateTime.now().year + 10,
                        ),

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
                              child: Container(
                                color: Colors.transparent,
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
                                Navigator.pop(context, _selectedDay);
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Text(
                                    S.current.ok,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().yellowColor(),
                                      20,
                                      FontWeight.w700,
                                    ),
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

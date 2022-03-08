import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/widgets/count_down_view/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TimeType {
  DAY,
  HOUR,
  MINUTE,
  SECOND,
}

class CountDownView extends StatefulWidget {
  final int timeInMilliSecond;
  final Function onRefresh;
  final int timeEnd;

  const CountDownView({
    Key? key,
    required this.timeInMilliSecond,
    required this.onRefresh,
    required this.timeEnd,
  }) : super(key: key);

  @override
  _CountDownViewState createState() => _CountDownViewState();
}

class _CountDownViewState extends State<CountDownView> {
  late final TimeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TimeBloc();
    _bloc.add(StartEvent(widget.timeInMilliSecond));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82.h,
      width: 343.w,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: BlocConsumer<TimeBloc, TimeState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is CompletedState) {
                  _bloc.add(StartEvent(widget.timeEnd));
                }
              },
              builder: (context, state) {
                final int time = state.timeDuration;
                if(time == 1) {
                  widget.onRefresh();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    timeCountDown(
                      setValueTime(time, TimeType.DAY),
                      S.current.day,
                    ),
                    timeCountDown(
                      setValueTime(time, TimeType.HOUR),
                      S.current.hour,
                    ),
                    timeCountDown(
                      setValueTime(time, TimeType.MINUTE),
                      S.current.minute,
                    ),
                    timeCountDown(
                      setValueTime(time, TimeType.SECOND),
                      S.current.second,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int setValueTime(int time, TimeType timeType) {
    int value;
    int _time = time;
    switch (timeType) {
      case TimeType.DAY:
        value = _time ~/ (24 * 60 * 60);
        break;
      case TimeType.HOUR:
        value = _time ~/ (24 * 60 * 60);
        _time = _time - value * (24 * 60 * 60);
        value = _time ~/ (60 * 60);
        break;
      case TimeType.MINUTE:
        value = _time ~/ (24 * 60 * 60);
        _time = _time - value * (24 * 60 * 60);
        value = _time ~/ (60 * 60);
        _time = _time - value * (60 * 60);
        value = _time ~/ 60;
        break;
      default:
        value = _time ~/ (24 * 60 * 60);
        _time = _time - value * (24 * 60 * 60);
        value = _time ~/ (60 * 60);
        _time = _time - value * (60 * 60);
        value = _time ~/ 60;
        value = _time - value * 60;
    }
    return value;
  }

  Widget timeCountDown(int time, String timeType) {
    return Container(
      width: 73.w,
      height: 82.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: AppTheme.getInstance().timeBorderColor(),
        ),
        color: AppTheme.getInstance().selectDialogColor(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              time.toString(),
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                24,
                FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Text(
              timeType,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                16,
                FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

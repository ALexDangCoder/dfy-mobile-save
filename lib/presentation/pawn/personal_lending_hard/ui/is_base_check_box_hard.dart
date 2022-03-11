import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

class IsBaseCheckBoxHard extends StatelessWidget {
  final String title;
  final Function funText;
  final Function funCheckBox;
  final BehaviorSubject<bool> stream;

  IsBaseCheckBoxHard({
    Key? key,
    required this.title,
    required this.stream,
    required this.funText,
    required this.funCheckBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: StreamBuilder(
            stream: stream,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return Transform.scale(
                scale: 1.4.sp,
                child: Checkbox(
                  fillColor: MaterialStateProperty.all(
                    AppTheme.getInstance().fillColor(),
                  ),
                  checkColor: AppTheme.getInstance().whiteColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  side: BorderSide(
                    width: 1.w,
                    color: AppTheme.getInstance().whiteColor(),
                  ),
                  value: snapshot.data ?? false,
                  onChanged: (value) {
                    funCheckBox(title);
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 10,
          child: Wrap(
            children: [
              GestureDetector(
                onTap: () {
                  funText(title);
                },
                child: Text(
                  title,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonGold extends StatelessWidget {
  final String title;
  final bool isEnable;

  const ButtonGold({
    Key? key,
    required this.title,
    required this.isEnable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 26.w, left: 26.w, bottom: 38),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 4,
          center: const Alignment(0.5, -0.5),
          colors: isEnable
              ? [
                  const Color(0xffFFE284),
                  const Color(0xffE4AC1A),
                ]
              : [
                  const Color(0xffCDCDCD),
                  const Color(0xffCDCDCD),
                ],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(22),
        ),
      ),
      height: 64.h,
      width: 298.w,
      child: Center(
        child: Text(
          widget.title,
          style: textNormal(
            AppTheme.getInstance().textThemeColor(),
            20.sp,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

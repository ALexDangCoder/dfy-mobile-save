import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLuxury extends StatelessWidget {
  final String title;
  final bool isEnable;

  const ButtonLuxury({
    Key? key,
    required this.title,
    required this.isEnable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 26.w, left: 26.w, bottom: 38.h),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 4,
          center: const Alignment(0.5, -0.5),
          colors: isEnable
              ? AppTheme.getInstance().gradientButtonColor()
              : [
                  AppTheme.getInstance().disableColor(),
                  AppTheme.getInstance().disableColor()
                ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.r),
        ),
      ),
      height: 48.h,
      width: 298.w,
      child: Center(
        child: Text(
          title,
          style: textNormal(
            AppTheme.getInstance().textThemeColor(),
            16.sp,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

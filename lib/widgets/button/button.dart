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
      margin: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 38.h),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 4.r,
          center: const Alignment(0.5, -0.5),
          colors: isEnable
              ? AppTheme.getInstance().gradientButtonColor()
              : [AppTheme.getInstance().disableColor()
            ,AppTheme.getInstance().disableColor()],
        ),
        borderRadius:  BorderRadius.all(
          Radius.circular(22.r),
        ),
      ),
      height: 64.h,
      width: 343.w,
      child: Center(
        child: Text(
          title,
          style: textNormal(
            AppTheme.getInstance().textThemeColor(),
            20,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

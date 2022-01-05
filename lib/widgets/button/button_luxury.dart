import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLuxury extends StatelessWidget {
  final String title;
  final bool isEnable;
  final double marginHorizontal;
  final double buttonHeight;
  final double fontSize;
  final Function()? onTap;

  const ButtonLuxury({
    Key? key,
    required this.title,
    required this.isEnable,
    this.marginHorizontal = 26,
    this.buttonHeight = 48,
    this.fontSize = 16,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          right: marginHorizontal.w,
          left: marginHorizontal.w,
          bottom: 38.h,
        ),
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
        height: buttonHeight.h,
        width: 298.w,
        child: Center(
          child: Text(
            title,
            style: textNormal(
              AppTheme.getInstance().textThemeColor(),
              fontSize.sp,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

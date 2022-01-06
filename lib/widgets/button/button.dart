import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonGold extends StatelessWidget {
  final String title;
  final bool isEnable;
  final bool? fixSize;
  final double? height;
  final double? radiusButton;
  final bool? haveMargin;

  const ButtonGold({
    Key? key,
    required this.title,
    required this.isEnable,
    this.fixSize = true,
    this.haveMargin = true,
    this.height,
    this.radiusButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: haveMargin ?? true
          ? EdgeInsets.only(
              right: 16.w,
              left: 16.w,
            )
          : null,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 4.r,
          center: const Alignment(0.5, -0.5),
          colors: isEnable
              ? AppTheme.getInstance().gradientButtonColor()
              : [
                  AppTheme.getInstance().errorColorButton(),
                  AppTheme.getInstance().errorColorButton(),
                ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radiusButton ?? 22.r),
        ),
      ),
      height: height ?? 64.h,
      width: fixSize == true ? 343.w : null,
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

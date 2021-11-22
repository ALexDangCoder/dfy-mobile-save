import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
Widget roundButton({
  required String image,
  bool whiteBackground = false,
}) {
  return Container(
    padding: EdgeInsets.all(4.h),
    height: 32.h,
    width: 32.h,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: whiteBackground
          ? AppTheme.getInstance().whiteBackgroundButtonColor()
          : AppTheme.getInstance().backgroundButtonColor(),
    ),
    child: Center(
      child: SvgPicture.asset(
        image,
      ),
    ),
  );
}
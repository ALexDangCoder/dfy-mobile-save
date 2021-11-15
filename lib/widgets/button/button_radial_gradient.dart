import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ButtonRadial extends StatelessWidget {
  final Widget child;

  const ButtonRadial({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      width: 298.w,
      decoration: BoxDecoration(
        gradient:  RadialGradient(
          center: const Alignment(0.5, -0.5),
          radius: 4,
          colors: AppTheme.getInstance().gradientButtonColor(),
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: child,
    );
  }
}

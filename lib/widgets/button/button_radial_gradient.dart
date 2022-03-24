import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ButtonRadial extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final double? radius;

  const ButtonRadial({
    Key? key,
    required this.child,
    this.height, this.width, this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 64.h,
      width: width,
      decoration: BoxDecoration(
        gradient:  RadialGradient(
          center: const Alignment(0.5, -0.5),
          radius: 4,
          colors: AppTheme.getInstance().gradientButtonColor(),
        ),
        borderRadius: BorderRadius.circular(radius ?? 22.r),
      ),
      child: child,
    );
  }
}

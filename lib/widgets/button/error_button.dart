import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;


  const ErrorButton({
    Key? key,
    required this.child, this.width, this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 64.h,
      width: width,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().errorColorButton(),
        borderRadius: BorderRadius.circular(22),
      ),
      child: child,
    );
  }
}

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonTransparent extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const ButtonTransparent({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 298.w,
      height: 64.h,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(22.0)),
          border: Border.all(color: AppTheme.getInstance().fillColor())),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ButtonGradient extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final Function onPressed;

  const ButtonGradient({
    Key? key,
    required this.child,
    required this.gradient,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 298.w,
      height: 64.h,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadius.all(Radius.circular(22.0)),
      ),
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

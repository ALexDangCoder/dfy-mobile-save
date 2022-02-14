import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonCustom extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final bool isEnable;
  final bool isProcess;

  const ButtonCustom({
    Key? key,
    required this.child,

    required this.onPressed,
    this.isEnable = true,
    this.isProcess = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onPressed : null,
      child: Container(
        height: 64.h,
        decoration: BoxDecoration(
          gradient: isEnable
              ? RadialGradient(
                  center: const Alignment(0.5, -0.5),
                  radius: 4,
                  colors: AppTheme.getInstance().gradientButtonColor(),
                )
              : RadialGradient(
                  center: const Alignment(0.5, -0.5),
                  radius: 4,
                  colors: [AppTheme.getInstance().errorColorButton()],
                ),
          borderRadius: BorderRadius.all(Radius.circular(22.0.r)),
        ),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: !isProcess
                ? child
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: CircularProgressIndicator(
                          color: AppTheme.getInstance().fillColor(),
                        ),
                      ),
                      spaceW8,
                      child
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

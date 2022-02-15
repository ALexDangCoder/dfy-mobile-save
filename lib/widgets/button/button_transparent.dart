import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonTransparent extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final bool isEnable;
  final bool isProcess;

  const ButtonTransparent({
    Key? key,
    required this.child,
    required this.onPressed,
    this.isEnable = true,
    this.isProcess = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 298.w,
      height: 64.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(22.r)),
        border: Border.all(
          color: isEnable
              ? AppTheme.getInstance().fillColor()
              : AppTheme.getInstance().errorColorButton(),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnable ? onPressed : null,
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

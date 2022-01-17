import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Vẫn là button Luxury nhưng Size lớn hơn :D
class ButtonLuxuryBigSize extends StatelessWidget {
  final String title;
  final bool isEnable;
  final void Function() onTap;

  const ButtonLuxuryBigSize({
    Key? key,
    required this.title,
    required this.isEnable,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 38.h, horizontal: 16.w),
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
            Radius.circular(22.r),
          ),
        ),
        height: 64.h,
        child: Center(
          child: Text(
            title,
            style: textNormal(
              AppTheme.getInstance().textThemeColor(),
              20.sp,
            ).copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

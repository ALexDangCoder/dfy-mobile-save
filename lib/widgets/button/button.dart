import 'package:Dfy/config/resources/color.dart';
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
  final double? textSize;
  final bool? haveGradient;
  final Border? border;
  final Color? textColor;
  final Color? background;
  final bool? isProcessing;

  const ButtonGold({
    Key? key,
    required this.title,
    required this.isEnable,
    this.isProcessing = false,
    this.fixSize = true,
    this.haveGradient = true,
    this.haveMargin = true,
    this.height,
    this.radiusButton,
    this.textSize,
    this.border,
    this.background,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 10),
      margin: haveMargin ?? true
          ? EdgeInsets.only(
              right: 16.w,
              left: 16.w,
            )
          : null,
      decoration: BoxDecoration(
        gradient: haveGradient ?? true
            ? RadialGradient(
                radius: 4.r,
                center: const Alignment(0.5, -0.5),
                colors: isEnable
                    ? AppTheme.getInstance().gradientButtonColor()
                    : [
                        AppTheme.getInstance().errorColorButton(),
                        AppTheme.getInstance().errorColorButton(),
                      ],
              )
            : null,
        color: background,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusButton ?? 22.r),
        ),
        border: border,
      ),
      height: height ?? 64.h,
      width: fixSize == true ? 343.w : null,
      child: (isProcessing ?? false) ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: CircularProgressIndicator(
              strokeWidth: 4.r,
              color: AppTheme.getInstance().whiteColor(),
            ),
          ),
          spaceW10,
          Text(
            'Processing',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w700,
            ),
          ),
        ],
      ) : SizedBox(
        child: Align(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: textNormal(
              textColor ?? AppTheme.getInstance().textThemeColor(),
              textSize ?? 20,
            ).copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

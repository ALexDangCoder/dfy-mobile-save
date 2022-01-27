import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemWorkingTime extends StatelessWidget {
  final String text;

  const ItemWorkingTime({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43.w,
      height: 43.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: AppTheme.getInstance().itemBtsColors(),
        border: Border.all(
          color: AppTheme.getInstance().selectDialogColor(),
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 2.h,
      ),
      child: Center(
        child: Text(
          text,
          style: textNormalCustom(
            null,
            14,
            null,
          ).copyWith(overflow: TextOverflow.ellipsis),
          maxLines: 1,
        ),
      ),
    );
  }
}

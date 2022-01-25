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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: AppTheme.getInstance().itemBtsColors(),
        border: Border.all(
          color: AppTheme.getInstance().selectDialogColor(),
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 7.w,
        vertical: 12.h,
      ),
      child: Text(
        text,
        style: textNormalCustom(
          null,
          14,
          null,
        ).copyWith(overflow: TextOverflow.ellipsis),
        maxLines: 1,
      ),
    );
  }
}

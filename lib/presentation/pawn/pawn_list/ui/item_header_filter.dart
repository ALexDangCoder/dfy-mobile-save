import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemHeaderFilter extends StatelessWidget {
  final String title;

  const ItemHeaderFilter({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 6.w,
            right: 4.w,
            top: 5.h,
            bottom: 5.h,
          ),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().borderItemColor(),
            borderRadius: BorderRadius.all(
              Radius.circular(9.r),
            ),
            border: Border.all(
              color: AppTheme.getInstance().selectDialogColor(),
              width: 1.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: textNormalCustom(
                  null,
                  14,
                  FontWeight.w400,
                ),
              ),
              spaceW6,
              Image.asset(
                ImageAssets.ic_line_down,
                height: 20.sp,
                width: 20.sp,
              ),
            ],
          ),
        )
      ],
    );
  }
}

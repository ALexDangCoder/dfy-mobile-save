import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypeNFTBox extends StatelessWidget {
  final String image;
  final String text;

  const TypeNFTBox({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppTheme.getInstance().itemBtsColors(),
        border: Border.all(
          color: AppTheme.getInstance().selectDialogColor(),
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
        horizontal: 2.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 24.w,
            height: 24.h,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 24.w,
              height: 24.h,
              color: AppTheme.getInstance().backgroundBTSColor(),
            ),
          ),
          Text(
            text,
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              14,
              FontWeight.w400,
            ).copyWith(
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          )
        ],
      ),
    );
  }
}

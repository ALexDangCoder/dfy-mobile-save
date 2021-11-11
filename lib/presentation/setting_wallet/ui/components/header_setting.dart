import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container headerSetting({
  required Function()? leftFunction,
  required Function()? rightFunction,
}) {
  return Container(
    // height: 28.h,
    width: 343.w,
    margin: EdgeInsets.only(
      right: 16.w,
      left: 16.w,
      top: 16.h,
      bottom: 20.h,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: IconButton(
            icon: Image.asset(ImageAssets.back),
            onPressed: leftFunction,
          ),
        ),
        Text(
          S.current.setting,
          style: textNormalCustom(
            Colors.white,
            20.sp,
            FontWeight.bold,
          ),
        ),
        GestureDetector(
          child: Text(
            S.current.lock,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(228, 172, 26, 1),
            ),
          )
        )
      ],
    ),
  );
}

import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Dfy/generated/l10n.dart';

Container headerChangePW({
  required Function()? callBack,
}) {
  return Container(
    margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
    width: 343.w,
    child: Row(
      children: [
        IconButton(
          onPressed: callBack,
          icon: Image.asset(ImageAssets.ic_back),
        ),
        SizedBox(width: 68.w,),
        Text(
            S.current.change_password,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: Colors.white,
            ),
          ),

      ],
    ),
  );
}

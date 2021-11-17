import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container headerPRVAndSeedPhr({
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
            icon: Image.asset(ImageAssets.ic_back),
            onPressed: leftFunction,
          ),
        ),
        Text(
          S.current.prv_key_ft_seed_phr,
          style: textNormalCustom(
            Colors.white,
            20,
            FontWeight.bold,
          ),
        ),
        GestureDetector(
            child: IconButton(
              icon: Image.asset(ImageAssets.ic_close),
              onPressed: leftFunction,
            ),
        )
      ],
    ),
  );
}

import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Widget btnAdd({
  required Function() onTap,
  required String content,
  bool isEnable = true,
}) {
  return InkWell(
    onTap: isEnable ? onTap : null,
    child: Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 1.h,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
      ),
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.w,
            height: 20.h,
            child: Image.asset(
              ImageAssets.addPropertiesNft,
            ),
          ),
          spaceW8,
          Text(
            content,
            style: textNormalCustom(
              isEnable
                  ? AppTheme.getInstance().fillColor()
                  : AppTheme.getInstance().disableColor(),
              16,
              FontWeight.w400,
            ),
          )
        ],
      ),
    ),
  );
}

Positioned positionedBtn({
  double? topSpace,
  double? bottomSpace,
  double? rightSpace,
  double? leftSpace,
  required Function() onPressed,
  required int size,
  required String icon,
}) {
  return Positioned(
    top: topSpace?.h,
    right: rightSpace?.h,
    left: leftSpace?.h,
    bottom: bottomSpace?.h,
    child: IconButton(
      onPressed: onPressed,
      icon: SizedBox(
        height: size.h,
        width: size.w,
        child: Image.asset(icon),
      ),
    ),
  );
}

Widget smallImageWidget(
  String _path, {
  int imgCount = 0,
  required String type,
}) {
  return imgCount > 0
      ? Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          height: 83.h,
          width: 105.w,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: (type == MEDIA_IMAGE_FILE)
                    ? Image.file(
                        File(_path),
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(ImageAssets.play_btn_svg),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: Text('+ $imgCount'),
                ),
              ),
            ],
          ),
        )
      : Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          height: 83.h,
          width: 105.w,
          child: (type == MEDIA_IMAGE_FILE)
              ? Image.file(
                  File(_path),
                  fit: BoxFit.cover,
                )
              : SvgPicture.asset(ImageAssets.play_btn_svg),
        );
}

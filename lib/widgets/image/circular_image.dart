import 'package:Dfy/config/themes/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox circularImage(
  String img, {
  required double height,
  required double width,
}) {
  return SizedBox(
    width: width.w,
    height: height.w,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(width.w.r),
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            color: AppTheme.getInstance().bgBtsColor(),
          ),
        ),
        imageUrl: img,
        fit: BoxFit.cover,
      ),
    ),
  );
}

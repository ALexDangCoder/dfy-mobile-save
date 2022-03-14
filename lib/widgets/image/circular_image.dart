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
      child: FadeInImage.assetNetwork(
        placeholder: '',
        placeholderErrorBuilder: (context, url, error) {
          return const SizedBox();
        },
        image: img,
        imageCacheHeight: 200,
        imageErrorBuilder: (context, url, error) {
          return const SizedBox();
        },
        placeholderCacheHeight: 50,
        fit: BoxFit.cover,
      ),
    ),
  );
}

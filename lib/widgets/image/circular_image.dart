import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container circularImage(
  String img, {
  required double height,
  required double width,
}) {
  return Container(
    width: width.w,
    height: height.w,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(width.w.r),
      child: Image.network(
        img,
        fit: BoxFit.cover,
      ),
    ),
  );
}

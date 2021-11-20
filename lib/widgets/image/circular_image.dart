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
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      // border: Border.all(
      //     color: Colors.teal, width: 10.0, style: BorderStyle.solid),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(img),
      ),
    ),
  );
}

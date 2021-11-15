import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget sizedPngImage({
  required double w,
  required double h,
  required String image,
}) {
  return SizedBox(
    height: h.h,
    width: w.h,
    child: Image.asset(
      image,
      fit: BoxFit.fill,
    ),
  );
}
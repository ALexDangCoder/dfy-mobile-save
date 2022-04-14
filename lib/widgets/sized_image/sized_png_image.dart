import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget sizedPngImage({
  required double w,
  required double h,
  required String image,
}) {
  return SizedBox(
    height: h.h,
    width: w.w,
    child: Image.asset(
      image,
      fit: BoxFit.fill,
    ),
  );
}

Widget sizedSvgImage({
  required double w,
  required double h,
  required String image,
}) {
  return SizedBox(
    height: h.h,
    width: w.w,
    child: Center(
      child: SvgPicture.asset(
        image,
        fit: BoxFit.fill,
      ),
    ),
  );
}

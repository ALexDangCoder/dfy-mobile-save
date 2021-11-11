import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container faceIDButton() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xffE4AC1A).withOpacity(0.5),
      borderRadius: BorderRadius.all(Radius.circular(12.r)),
    ),
    height: 54.h,
    width: 54.w,
    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
    child: Image.asset(ImageAssets.face_id),
  );
}

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container formSetupPassWord({
  required TextEditingController controller,
  required String hintText,
  String? oldPassWordFetch,
}) {
  return Container(
    height: 64.h,
    width: 323.w,
    padding: EdgeInsets.only(
      top: 12.h,
      bottom: 12.h,
    ),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      color: Color(0xff32324c),
    ),
    child: TextFormField(
      style: textNormal(
        Colors.white,
        16.sp,
      ),
      cursorColor: Colors.white,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textNormal(
          Colors.grey,
          14.sp,
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: const ImageIcon(
            AssetImage(ImageAssets.hide),
            color: Colors.grey,
          ),
        ),
        prefixIcon: const ImageIcon(
          AssetImage(ImageAssets.lock),
          color: Colors.white,
        ),
        border: InputBorder.none,
      ),
    ),
  );
}

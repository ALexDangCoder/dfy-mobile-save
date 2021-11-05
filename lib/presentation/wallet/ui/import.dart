import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImportToken extends StatelessWidget {
  const ImportToken({Key? key, required this.title, required this.icon})
      : super(key: key);
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 1.h,
          color: const Color(0xFF4b4a60),
        ),
        SizedBox(
          height: 60.h,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage(icon),
                  color: const Color(0xFFE4AC1A),
                  size: 24.sp,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  title,
                  style: textNormalCustom(
                    const Color(0xFFE4AC1A),
                    16.sp,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1.h,
          color: const Color(0xFF4b4a60),
        ),
      ],
    );
  }
}

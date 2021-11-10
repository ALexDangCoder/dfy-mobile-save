import 'package:Dfy/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InkWell buildColumnButton({
  required String path,
  //String? label,
  Function()? callback,
}) {
  return InkWell(
    onTap: callback,
    child: Column(
      children: [
        Container(
          height: 48.h,
          width: 48.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromRGBO(255, 255, 255, 0.2),
            image: DecorationImage(image: AssetImage(path)),
          ),
        ),
        // SizedBox(
        //   height: 8.h,
        // ),
        // Expanded(
        //   child: SizedBox(
        //     height: 22.h,
        //     child: Text(
        //       label ?? '',
        //       style: textNormalCustom(
        //         null,
        //         16.sp,
        //         FontWeight.w400,
        //       ),
        //     ),
        //   ),
        //),
      ],
    ),
  );
}

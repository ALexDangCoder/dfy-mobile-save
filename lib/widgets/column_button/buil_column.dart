
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InkWell buildColumnButton({
  required String path,
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
      ],
    ),
  );
}

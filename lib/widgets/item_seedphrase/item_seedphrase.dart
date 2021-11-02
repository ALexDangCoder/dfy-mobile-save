import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemSeedPhrase extends StatelessWidget {
  final String title;
  const ItemSeedPhrase({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(
          vertical: 5.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
        Border.all(color: Colors.white, width: 1.w),
        borderRadius:
        const BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        title,
        style:
        TextStyle(color: Colors.white, fontSize: 16.sp),
      ),
    );
  }
}

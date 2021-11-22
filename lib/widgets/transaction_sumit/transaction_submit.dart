import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//todo handle indicator using https://pub.dev/packages/step_progress_indicator
class TransactionSubmit extends StatelessWidget {
  const TransactionSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4,
        sigmaY: 4,
      ),
      child: Container(
        height: 101.h,
        width: 232.w,
        padding: EdgeInsets.only(top: 313.h, left: 71.5.w, right: 71.5.w),
        child: Container(
          padding: EdgeInsets.only(
            top: 11.h,
            right: 38.5.w,
            left: 38.5.w,
          ),
          decoration: const BoxDecoration(
            color: Color(0xff585782),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(

          ),
        ),
      ),
    );
  }
}

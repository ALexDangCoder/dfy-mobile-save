import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FromText extends StatefulWidget {
  final String urlPrefixIcon;
  final String title;
  final String urlSuffixIcon;

  const FromText(
      {Key? key,
      required this.urlPrefixIcon,
      required this.title,
      required this.urlSuffixIcon})
      : super(key: key);

  @override
  _FromTextState createState() => _FromTextState();
}

class _FromTextState extends State<FromText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 323.w,
        height: 64.h,
        margin: EdgeInsets.symmetric(horizontal: 26.w),
        padding: EdgeInsets.symmetric(horizontal: 15.5.w, vertical: 23.h),
        decoration: const BoxDecoration(
          color: Color(0x80A7A7A7),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  widget.urlPrefixIcon,
                  height: 17.67,
                  width: 19.14,
                ),
                SizedBox(
                  width: 17.5.w,
                ),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              ],
            ),
            Container(
              child: widget.urlSuffixIcon.isNotEmpty
                  ? Image.asset(
                      widget.urlSuffixIcon,
                      height: 17.67.h,
                      width: 19.14.w,
                    )
                  : null,
            )
          ],
        ));
  }
}

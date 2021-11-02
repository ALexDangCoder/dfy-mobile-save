import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FromSwitch extends StatefulWidget {
  final bool isCheck;
  final String title;
  final String urlPrefixIcon;

  const FromSwitch(
      {Key? key,
      required this.isCheck,
      required this.title,
      required this.urlPrefixIcon})
      : super(key: key);

  @override
  _FromSwitchState createState() => _FromSwitchState();
}

class _FromSwitchState extends State<FromSwitch> {
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
            Image.asset(widget.urlPrefixIcon),
            SizedBox(
              width: 11.w,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
          Switch(
            value: widget.isCheck,
            onChanged: (value) {
              setState(() {});
            },

            activeTrackColor: Colors.amber,
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonGold extends StatefulWidget {
  final String title;

  const ButtonGold({Key? key, required this.title}) : super(key: key);

  @override
  _ButtonGoldState createState() => _ButtonGoldState();
}

class _ButtonGoldState extends State<ButtonGold> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 26.w, left: 26.w, bottom: 38),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          radius: 4,
          center: Alignment(0.5, -0.5),
          colors: [
            Color(0xffFFE284),
            Color(0xffE4AC1A),
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(22),
        ),
      ),
      height: 64.h,
      width: 298.w,
      child: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

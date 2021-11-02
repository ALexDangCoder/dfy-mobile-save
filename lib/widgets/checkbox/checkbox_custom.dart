import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckBoxCustom extends StatefulWidget {
  final String title;

  const CheckBoxCustom({Key? key, required this.title}) : super(key: key);

  @override
  _CheckBoxCustomState createState() => _CheckBoxCustomState();
}

class _CheckBoxCustomState extends State<CheckBoxCustom> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: true,
          onChanged: (value) {},
          activeColor: const Color(0xffE4AC1A),
        ),
        Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        )
      ],
    );
  }
}

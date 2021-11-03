import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderCreate extends StatelessWidget {
  const HeaderCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Image.asset(
            'assets/images/ic_out.png',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: 66.w,
        ),
        Text(
          'Create new wallet',
          style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,),
        ),
        SizedBox(
          width: 64.w,
        ),
        GestureDetector(
          child: Image.asset(
            'assets/images/ic_close.png',
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

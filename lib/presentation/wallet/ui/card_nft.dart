import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardNFT extends StatelessWidget {
  const CardNFT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Row(
        children: [
          Container(
            height: 102.h,
            width: 88.w,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/demo.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(
                10.sp,
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCreateSuccessfully(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: 764.h,
        width: 375.w,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          color: const Color(0xff3e3d5c),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.h),
            topRight: Radius.circular(30.h),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 18.h,
            ),
            Center(
              child: Text(
                'Create new wallet successfully',
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              height: 1.h,
              color: Color.fromRGBO(255, 255, 255, 0.1),
            ),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('$baseImg/ic_frame.png'),
                    SizedBox(
                      height: 22.h,
                    ),
                    Text(
                      'Congratulation!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32.sp,),
                    ),
                    SizedBox(
                      height: 111.h,
                    ),
                    const FromSwitch(
                      title: 'Use face/touch ID',
                      isCheck: true,
                      urlPrefixIcon: '$baseImg/ic_faceid.png',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const FromSwitch(
                      title: 'Wallet app lock',
                      isCheck: false,
                      urlPrefixIcon: '$baseImg/ic_password.png',
                    ),
                    SizedBox(
                      height: 56.h,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: ButtonGold(
                  title: 'Complete',
                  isEnable: false,
                ),
              ),
            ),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      );
    },
  );
}

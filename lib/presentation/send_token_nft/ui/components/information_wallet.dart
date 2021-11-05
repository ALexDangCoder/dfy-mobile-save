import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationWallet extends StatelessWidget {
  const InformationWallet({
    Key? key,
    required this.nameWallet,
    required this.fromAddress,
    required this.amount,
    required this.nameToken,
    required this.imgWallet,
  }) : super(key: key);

  final String nameWallet;
  final String fromAddress;
  final double amount;
  final String nameToken;
  final String imgWallet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 26.w,
        right: 26.w,
      ),
      child: Container(
        width: 323.w,
        height: 74.h,
        decoration: BoxDecoration(
            // color: const Color.fromRGBO(255, 255, 255, 0.1),
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            border:
                Border.all(color: const Color.fromRGBO(255, 255, 255, 0.1)),),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 12.w,
                top: 16.h,
                bottom: 18.h,
              ),
              child: circularImage(imgWallet),
            ),
            Column(
              children: [
                SizedBox(
                  width: 7.35.w,
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: 8.35.w,
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //hang1
                  Padding(
                    padding: EdgeInsets.only(top: 14.h),
                    child: Row(
                      children: [
                        Text(
                          nameWallet,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          fromAddress,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: const Color.fromRGBO(255, 255, 255, 0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  //hang 2
                  Text(
                    'Balance: $amount $nameToken',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container circularImage(String img) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // border: Border.all(
        //     color: Colors.teal, width: 10.0, style: BorderStyle.solid),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(img),
        ),
      ),
    );
  }
}

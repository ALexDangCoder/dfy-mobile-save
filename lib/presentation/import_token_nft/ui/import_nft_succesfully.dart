import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/image_asset.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showNFTSuccessfully(BuildContext context) {
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
                'Import NFT successfully',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            spaceH20,
            line,
            spaceH24,
            SizedBox(
              height: 56.h,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageAssets.icFrame),
                  SizedBox(
                    height: 22.h,
                  ),
                  Text(
                    'Congratulation!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.sp,
                    ),
                  ),
                  SizedBox(
                    height: 170.h,
                  ),
                  SizedBox(
                    height: 56.h,
                  ),
                ],
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRouter.main,
                    (route) => route.isFirst,
                  );
                },
                child: const ButtonGold(
                  title: 'Complete',
                  isEnable: true,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
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
          color: AppTheme.getInstance().bgBtsColor(),
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
                S.current.nft_successfully,
                style: textNormalCustom(
                  Colors.white,
                  20.sp,
                  FontWeight.bold,
                ),
              ),
            ),
            spaceH20,
            line,
            spaceH24,
            SizedBox(
              height: 56.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 228.h,
                        width: 305.w,
                        child: Image.asset(ImageAssets.frameGreen),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      Text(
                        S.current.congratulation,
                        style: textNormalCustom(
                          Colors.white,
                          32.sp,
                          FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 213.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: ButtonGold(
                  title: S.current.complete,
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

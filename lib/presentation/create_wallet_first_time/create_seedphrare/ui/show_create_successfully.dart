import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
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
                S.current.success,
                style: textNormal(
                  AppTheme.getInstance().whiteWithOpacity(),
                  20.sp,
                ).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              height: 1.h,
              color: AppTheme.getInstance().divideColor(),
            ),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(ImageAssets.ic_frame),
                    SizedBox(
                      height: 22.h,
                    ),
                    Text(
                      S.current.congratulation,
                      style: textNormal(
                        AppTheme.getInstance().whiteWithOpacity(),
                        32.sp,
                      ).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 111.h,
                    ),
                    FromSwitch(
                      title: S.current.use_face,
                      isCheck: true,
                      urlPrefixIcon: ImageAssets.ic_face_id,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    FromSwitch(
                      title: S.current.wallet_app_lock,
                      isCheck: false,
                      urlPrefixIcon: ImageAssets.ic_password,
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
                  title: S.current.complete,
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

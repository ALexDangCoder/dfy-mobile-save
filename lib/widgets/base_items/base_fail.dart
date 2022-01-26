import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseFail extends StatelessWidget {
  const BaseFail({
    Key? key,
    required this.title,
    this.content,
    required this.onTapBtn,
  }) : super(key: key);
  final String title;
  final String? content;
  final Function() onTapBtn;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          SizedBox(
            height: 228.h,
            width: 305.w,
            child: Image.asset(ImageAssets.img_fail),
          ),
          spaceH20,
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              content ?? S.current.oopps_omething_went_wrong,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                32,
                FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onTapBtn,
            child: ButtonGold(
              title: S.current.complete,
              isEnable: true,
            ),
          ),
          spaceH38
        ],
      ),
    );
  }
}

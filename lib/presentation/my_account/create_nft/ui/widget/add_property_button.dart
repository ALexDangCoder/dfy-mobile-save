import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget addPropertyButton() {
  return GestureDetector(
    onTap: (){
      log('TAP ADD MORE');
    },
    child: Container(
      height: 60.h,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppTheme.getInstance().divideColor(),
          ),
          bottom: BorderSide(
            color: AppTheme.getInstance().divideColor(),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          sizedSvgImage(w: 20, h: 20, image: ImageAssets.rec_plus_svg),
          spaceW8,
          Text(
            'Add more properties',
            style: textCustom(
              color: AppTheme.getInstance().fillColor(),
            ),
          ),
        ],
      ),
    ),
  );
}

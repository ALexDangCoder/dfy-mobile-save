import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonDashedAddImageFtVid extends StatelessWidget {
  const ButtonDashedAddImageFtVid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: Radius.circular(20.r),
      borderType: BorderType.RRect,
      color: AppTheme.getInstance().dashedColorContainer(),
      child: Container(
        padding: EdgeInsets.only(
          top: 20.h,
        ),
        width: 343.w,
        height: 133.h,
        child: Column(
          children: [
            Image.asset(
              ImageAssets.createNft,
            ),
            spaceH12,
            Text(
              'Format: mp4, WEBM, mp3, WAV,\n' +
                  '       OGG, png, jpg, jpeg, GIF',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

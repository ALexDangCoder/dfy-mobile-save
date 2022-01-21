import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleStepCreateNft extends StatelessWidget {
  const CircleStepCreateNft({
    Key? key,
    required this.circleStatus,
    required this.stepCreate,
  }) : super(key: key);
  final CircleStatus circleStatus;
  final String stepCreate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 30.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
          colors: circleStatus == CircleStatus.IS_CREATING
              ? AppTheme.getInstance().colorsCreateNFT()
              : [
            AppTheme.getInstance().bgProgressingColors(),
            AppTheme.getInstance().bgProgressingColors(),
          ],
        ),
        border: circleStatus == CircleStatus.IS_NOT_CREATE
            ? Border.all(
          color: AppTheme.getInstance().fillColor(),
        )
            : null,
      ),
      child: Center(
        child: Text(
          stepCreate,
          style: textNormalCustom(
            circleStatus == CircleStatus.IS_CREATING
                ? AppTheme.getInstance().bgProgressingColors()
                : AppTheme.getInstance().fillColor(),
            20,
            FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NoEvaluationResultWidget extends StatelessWidget {
  const NoEvaluationResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 90.h),
      child: Column(
        children: [
          Image(
            image:  const AssetImage(
              ImageAssets.img_search_empty,
            ),
            height: 120.h,
            width: 120.w,
          ),
          SizedBox(
            height: 17.7.h,
          ),
          Text(
            S.current.no_evaluation,
            style: textNormal(
              Colors.white54,
              20,
            ),
          ),
        ],
      ),
    );
  }
}

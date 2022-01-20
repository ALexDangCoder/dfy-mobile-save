import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessCkcCreateNft extends StatelessWidget {
  const SuccessCkcCreateNft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 30.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.getInstance().successTransactionColors(),
      ),
      child: SizedBox(
        height: 20.h,
        width: 20.w,
        child: Image.asset(
          ImageAssets.iconCheck,
        ),
      ),
    );
  }
}

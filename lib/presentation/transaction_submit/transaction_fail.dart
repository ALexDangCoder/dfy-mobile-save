import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionSubmitFail extends StatelessWidget {
  const TransactionSubmitFail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101.h,
      width: 232.w,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgTranSubmit(),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: Image.asset(ImageAssets.failSubmit),
            ),
          ),
          spaceH5,
          Expanded(
            child: Text(
              S.current.transaction_fail,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                16,
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

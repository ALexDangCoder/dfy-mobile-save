import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionSubmit extends StatelessWidget {
  const TransactionSubmit({Key? key, this.justLoading}) : super(key: key);
  final bool? justLoading;

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
              child: CircularProgressIndicator(
                backgroundColor: AppTheme.getInstance().disableColor(),
                strokeWidth: 3.w,
                color: AppTheme.getInstance().fillColor(),
              ),
            ),
          ),
          spaceH5,
          Expanded(
            child: Text(
              (justLoading ?? false) ? '': S.current.tran_submit,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                16,
                FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              S.current.waiting_for_cf,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                14,
                FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

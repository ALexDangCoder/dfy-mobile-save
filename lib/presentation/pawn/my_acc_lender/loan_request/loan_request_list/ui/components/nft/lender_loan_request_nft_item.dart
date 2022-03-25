import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LenderLoanRequestNftItem extends StatelessWidget {
  const LenderLoanRequestNftItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getInstance().divideColor(),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().bgBtsColor(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(),
          spaceH12,
          _rowItem(title: title, description: description)
        ],
      ),
    );
  }

  Row _rowItem({
    required String title,
    required Widget description,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: textNormalCustom(
              AppTheme.getInstance().pawnItemGray(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            description,
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              16,
              FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemRepaymentHistory extends StatelessWidget {
  const ItemRepaymentHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().borderItemColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        border: Border.all(
          color: AppTheme.getInstance().divideColor(),
        ),
      ),
      padding: EdgeInsets.only(
        right: 16.w,
        left: 16.w,
        top: 16.h,
        bottom: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          richText(
            title: '${S.current.repayment_date}:',
            value: '12:00  01/05/2021 ',
          ),
          spaceH16,
          richText(
            title: '${S.current.txn_hash}:',
            value: '12:00  01/05/2021 ',
          ),
          spaceH16,
          richText(
            title: '${S.current.penalty}:',
            value: '60/100 DFY',
            isIcon: true,
            url: ImageAssets.getUrlToken('DFY'),
          ),
          spaceH16,
          richText(
            title: '${S.current.interest}:',
            value: 'DFY 6.1',
            isIcon: true,
            url: ImageAssets.getUrlToken('DFY'),
          ),
          spaceH16,
          richText(
            title: '${S.current.loan}:',
            value: '0',
          ),
          spaceH16,
          richText(
            title: '${S.current.status}:',
            value: '12:00  01/05/2021 ',
            myColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

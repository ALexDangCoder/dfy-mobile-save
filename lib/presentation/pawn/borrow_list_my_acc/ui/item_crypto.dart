import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCrypto extends StatelessWidget {
  const ItemCrypto({Key? key}) : super(key: key);

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
        top: 18.h,
        bottom: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          richText(
            title: '${S.current.collateral}:',
            value: '10 DFY',
            url: ImageAssets.getUrlToken('DFY'),
            isIcon: true,
          ),
          spaceH16,
          richText(
            title: '${S.current.loan_amount}:',
            value: '10 DFY',
            url: ImageAssets.getUrlToken('DFY'),
            isIcon: true,
          ),
          spaceH16,
          richText(
            title: '${S.current.interest_rate_apr}:',
            value: '10%',
          ),
          spaceH16,
          richText(
            title: '${S.current.duration_pawn}:',
            value: '12 months',
          ),
          spaceH16,
          richText(
            title: '${S.current.status}:',
            value: 'Active',
            fontW: FontWeight.w600,
            myColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

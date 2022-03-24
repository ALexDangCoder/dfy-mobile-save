import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/home_pawn/crypto_pawn_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/bloc/borrow_list_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCrypto extends StatelessWidget {
  const ItemCrypto({
    Key? key,
    required this.obj,
    required this.bloc,
  }) : super(key: key);
  final CryptoPawnModel obj;
  final BorrowListMyAccBloc bloc;

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
            value: '${formatPrice.format(obj.collateralAmount)}'
                ' ${obj.collateral?.toUpperCase()}',
            url: ImageAssets.getUrlToken(obj.collateral.toString()),
            isIcon: true,
          ),
          spaceH16,
          richText(
            title: '${S.current.loan_amount}:',
            value: '${formatPrice.format(obj.supplyCurrencyAmount)}'
                ' ${obj.supplyCurrency?.toUpperCase()}',
            url: ImageAssets.getUrlToken('${obj.supplyCurrency}'),
            isIcon: true,
          ),
          spaceH16,
          richText(
            title: '${S.current.interest_rate_apr}:',
            value: '${obj.interestPerYear}%',
          ),
          spaceH16,
          richText(
            title: '${S.current.duration_pawn}:',
            value:
                '${obj.duration} ${obj.durationType == WEEK ? S.current.weeks_pawn : S.current.months_pawn}',
          ),
          spaceH16,
          richText(
            title: '${S.current.status}:',
            value: bloc.getStatus(obj.status ?? 0),
            fontW: FontWeight.w600,
            myColor: bloc.getColor(obj.status ?? 0),
          ),
        ],
      ),
    );
  }
}

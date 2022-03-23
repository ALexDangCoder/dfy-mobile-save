import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_crypto_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/extension/offer_sent_crypto_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/offer_sent_list_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/ui/components/detail_offer_sent.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final formatUSD = NumberFormat('###,###,###.###', 'en_US');

class OfferSentCryptoItem extends StatelessWidget {
  const OfferSentCryptoItem({
    Key? key,
    required this.model,
    required this.index,
    required this.cubit,
  }) : super(key: key);
  final OfferSentListCubit cubit;
  final OfferSentCryptoModel model;
  final int index;

  //todo define object

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => DetailOfferSent(
              cubit: cubit,
              idGetDetail: model.id ?? 0,
            ),
          ),
        ).then((value) => cubit.showContent());
      },
      child: Container(
        width: 343.w,
        padding: EdgeInsets.only(
          top: 16.h,
          left: 16.w,
          bottom: 20.h,
          right: 16.w,
        ),
        margin: EdgeInsets.only(
          bottom: 20.h,
          left: 16.w,
          right: 16.w,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rowItem(
              title: S.current.message,
              description: model.description ?? '',
            ),
            SizedBox(
              height: 17.w,
            ),
            _rowItem(
              title: S.current.loan_amount,
              description: formatUSD.format(model.supplyCurrency?.amount),
              isLoanAmount: true,
              urlToken: model.supplyCurrency?.symbol,
            ),
            SizedBox(
              height: 17.w,
            ),
            _rowItem(
              title: S.current.interest_rate,
              description: '${model.interestRate.toString()} %',
            ),
            SizedBox(
              height: 17.w,
            ),
            _rowItem(
              title: S.current.duration,
              description: cubit.categoryOneOrMany(
                durationQty: model.durationQty ?? 0,
                durationType: model.durationType ?? 0,
              ),
            ),
            SizedBox(
              height: 17.w,
            ),
            _rowItem(
              title: S.current.duration,
              description: model.status.toString(),
              isStatus: true,
              status: model.status,
            ),
          ],
        ),
      ),
    );
  }

  Row _rowItem({
    int? status,
    String? urlToken,
    required String title,
    bool isLoanAmount = false,
    bool isStatus = false,
    required String description,
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
        if (isLoanAmount)
          Expanded(
            flex: 6,
            child: Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child:
                      Image.network(ImageAssets.getUrlToken(urlToken ?? DFY)),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '$description $urlToken',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        else if (isStatus)
          Expanded(
            flex: 6,
            child: Text(
              OfferSentCryptoExtension.categoryStatus(model.status ?? 0),
              style: textNormalCustom(
                OfferSentCryptoExtension.getStatusColor(
                    status ?? OfferSentCryptoExtension.PROCESSING_CREATE),
                16,
                FontWeight.w400,
              ),
            ),
          )
        else
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

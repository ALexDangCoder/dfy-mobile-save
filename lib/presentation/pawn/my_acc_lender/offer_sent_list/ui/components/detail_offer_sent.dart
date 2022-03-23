import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/extension/offer_sent_crypto_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailOfferSent extends StatefulWidget {
  const DetailOfferSent({Key? key}) : super(key: key);

  @override
  _DetailOfferSentState createState() => _DetailOfferSentState();
}

class _DetailOfferSentState extends State<DetailOfferSent> {
  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: 'Offer detail',
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 24.h,
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Offer detail',
                style: textNormalCustom(
                  AppTheme.getInstance().unselectedTabLabelColor(),
                  14,
                  FontWeight.w400,
                ),
              ),
              spaceH16,
              _rowItem(title: S.current.offer, description: '')
            ],
          ),
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
    bool isLoanAmountNoAmount = false,
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
              OfferSentCryptoExtension.categoryStatus(0), //todo
              style: textNormalCustom(
                OfferSentCryptoExtension.getStatusColor(
                    status ?? OfferSentCryptoExtension.PROCESSING_CREATE),
                16,
                FontWeight.w400,
              ),
            ),
          )
        else if (isLoanAmountNoAmount)
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
                  urlToken ?? '',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ],
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

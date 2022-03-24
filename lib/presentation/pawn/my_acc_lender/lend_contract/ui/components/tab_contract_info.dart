import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/extension/offer_sent_crypto_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class TabContractInfo extends StatelessWidget {
  const TabContractInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 24.h,
        left: 16.w,
        right: 16.w,
        bottom: 30.h,
      ),
      child: Column(
        children: [
          _rowItem(
            title: S.current.contract_id.withColon(),
            description: 'contract id',
          ),
          spaceH16,
          _rowItem(
            title: S.current.default_date.withColon(),
            description: '12/05/2021',
          ),
          spaceH16,
          _rowItem(
            title: S.current.status.withColon(),
            description: '12/05/2021',
            status: 3,
            isStatus: true,
          ),
          spaceH16,
          _rowItem(
            title: S.current.interest_rate,
            description: '12 %',
          ),
          spaceH16,
          _rowItem(
            title: S.current.collateral,
            description: '',
            isCustomWidget: true,
            widgetCustom: Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: Image.network(ImageAssets.getUrlToken(DFY)),
                ),
                spaceW8,
                Text(
                  '100 dfy',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceW16,
                Text(
                  '${S.current.view_all.capitalize()}',
                  style: textNormalCustom(
                    AppTheme.getInstance().fillColor(),
                    16,
                    FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          spaceH16,
          _rowItem(
            title: S.current.total_estimate.withColon(),
            description: '12',
            isEstimate: true,
          ),
          spaceH16,
          _rowItem(
            title: S.current.repayment_token.withColon(),
            isLoanAmountNoAmount: true,
            urlToken: DFY,
            description: '',
          ),
          spaceH16,
          _rowItem(
            title: S.current.recurring_interest,
            description: 'monthly',
          ),
          spaceH16,
          _rowItem(
            title: S.current.from.withColon(),
            description: '12.00',
          ),
          spaceH16,
          _rowItem(
            title: S.current.to.withColon(),
            description: '12.00',
          ),
          spaceH16,
          _rowItem(
            title: S.current.loan_to_value.withColon(),
            description: '',
            isCustomWidget: true,
            widgetCustom: Row(
              children: [
                SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: Image.asset(ImageAssets.ic_warn_grey),
                ),
                spaceW16,
                Text(
                  '16 %',
                  style: textNormalCustom(
                    AppTheme.getInstance().pawnItemGray(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          spaceH16,
          _rowItem(
            title: S.current.ltv_liquid_thres,
            description: '',
            isCustomWidget: true,
            widgetCustom: Row(
              children: [
                SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: Image.asset(ImageAssets.ic_warn_grey),
                ),
                spaceW16,
                Text(
                  '16 %',
                  style: textNormalCustom(
                    AppTheme.getInstance().pawnItemGray(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          spaceH16,
          _rowItem(
            title: S.current.sys_risk.withColon(),
            description: '12.00',
          ),
          spaceH16,
          _rowItem(
            title: S.current.default_reason.withColon(),
            description: '12.00',
          ),
        ],
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
    bool? isCustomWidget = false,
    bool? isLoanAmountNoAmount = false,
    bool? isEstimate = false,
    Widget? widgetCustom,
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
              'huy',
              style: textNormalCustom(
                OfferSentCryptoExtension.getStatusColor(0),
                16,
                FontWeight.w400,
              ),
            ),
          )
        else if (isLoanAmountNoAmount ?? false)
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
        else if (isCustomWidget ?? false)
          Expanded(flex: 6, child: widgetCustom ?? Container())
        else if (isEstimate ?? false)
          Expanded(
            flex: 6,
            child: Text(
              '~ \$$description',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
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

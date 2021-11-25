import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

enum IS_PAWN_OR_SALE {
  SEND_OFFER,
  BUY,
}

class FormSaleFtPawn extends StatelessWidget {
  const FormSaleFtPawn({
    required this.isPawnOrSale,
    this.quantity,
    this.pricePerOne,
    this.totalPayment,
    this.loanToVl,
    this.loanAmount,
    this.interestRate,
    this.ltvLiquidThreshold,
    this.duration,
    this.repaymentCurrent,
    this.recurringInterest,
    Key? key,
  }) : super(key: key);
  final int? quantity;
  final double? pricePerOne;
  final double? totalPayment;
  final double? loanToVl;
  final double? loanAmount;
  final double? interestRate;
  final double? ltvLiquidThreshold;
  final int? duration;
  final String? repaymentCurrent;
  final String? recurringInterest;
  final IS_PAWN_OR_SALE isPawnOrSale;

  @override
  Widget build(BuildContext context) {
    final formatValue = NumberFormat('###,###,###.###', 'en_US');

    // formatValue.format(DOUBLE), // HOW TO USE IT
    if (isPawnOrSale == IS_PAWN_OR_SALE.BUY) {
      return Container(
        margin: EdgeInsets.only(
          left: 10.w,
          top: 19.h,
          // bottom: 20.h,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 250.w,
            minHeight: 92.h,
          ),
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${S.current.quantity}:',
                      style: textNormalCustom(
                        Colors.white.withOpacity(0.7),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH16,
                    Text(
                      '${S.current.price_per_1}:',
                      style: textNormalCustom(
                        Colors.white.withOpacity(0.7),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH16,
                    Text(
                      '${S.current.total_payment_normal}:',
                      style: textNormalCustom(
                        Colors.white.withOpacity(0.7),
                        16,
                        FontWeight.w400,
                      ),
                    )
                  ],
                ),
                spaceW16,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$quantity',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      formatValue.format(pricePerOne),
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Text(
                      '${formatValue.format(totalPayment)} DFY',
                      style: textNormalCustom(
                        AppTheme.getInstance().fillColor(),
                        20,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 250.w,
          minHeight: 236.h,
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: 10.w,
            top: 24.h,
            bottom: 20.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${S.current.loan_to_vl}',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    '${S.current.loan_amount}',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    '${S.current.interest_rate}',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    '${S.current.ltv_liquid_thres}',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    '${S.current.duration}',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    '${S.current.repayment_curr}',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  Text(
                    '${S.current.recurring_interest}',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ],
              ),
              spaceW16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h,),
                  Text(
                    '$loanToVl%',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 19.h,
                  ),
                  Text(
                    '${formatValue.format(loanAmount)} DFY',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    '${formatValue.format(interestRate)} %',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Text(
                    '${formatValue.format(ltvLiquidThreshold)} %',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '${formatValue.format(duration)} months',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '$repaymentCurrent',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '$recurringInterest',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

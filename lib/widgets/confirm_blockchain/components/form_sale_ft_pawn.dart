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
            child: Column(
              children: [
                bothTxtFormAddFtAmount(
                  txtLeft: '${S.current.quantity}:',
                  txtRight: '$quantity',
                  styleLeft: textNormalCustom(
                    AppTheme.getInstance().currencyDetailTokenColor(),
                    16.sp,
                    FontWeight.w400,
                  ),
                  styleRight: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16.sp,
                    FontWeight.w400,
                  ),
                ),
                spaceH16,
                bothTxtFormAddFtAmount(
                  txtLeft: '${S.current.price_per_1}:',
                  txtRight: formatValue.format(pricePerOne),
                  styleLeft: textNormalCustom(
                    AppTheme.getInstance().currencyDetailTokenColor(),
                    16.sp,
                    FontWeight.w400,
                  ),
                  styleRight: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16.sp,
                    FontWeight.w400,
                  ),
                ),
                spaceH16,
                bothTxtFormAddFtAmount(
                  txtLeft: '${S.current.total_payment_normal}:',
                  txtRight: '${formatValue.format(totalPayment)} DFY',
                  styleLeft: textNormalCustom(
                    AppTheme.getInstance().currencyDetailTokenColor(),
                    16.sp,
                    FontWeight.w400,
                  ),
                  styleRight: textNormalCustom(
                    AppTheme.getInstance().fillColor(),
                    20.sp,
                    FontWeight.w600,
                  ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bothTxtFormAddFtAmount(
                txtLeft: S.current.loan_to_vl,
                txtRight: '$loanToVl%',
                styleLeft: textNormalCustom(
                  AppTheme.getInstance().currencyDetailTokenColor(),
                  16.sp,
                  FontWeight.w400,
                ),
                styleRight: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16.sp,
                  FontWeight.w400,
                ),
              ),
              spaceH16,
              bothTxtFormAddFtAmount(
                txtLeft: S.current.loan_amount,
                txtRight: '${formatValue.format(loanAmount)} DFY',
                styleLeft: textNormalCustom(
                  AppTheme.getInstance().currencyDetailTokenColor(),
                  16.sp,
                  FontWeight.w400,
                ),
                styleRight: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16.sp,
                  FontWeight.w400,
                ),
              ),
              spaceH16,
              bothTxtFormAddFtAmount(
                txtLeft: S.current.interest_rate,
                txtRight: '${formatValue.format(interestRate)} %',
                styleLeft: textNormalCustom(
                  AppTheme.getInstance().currencyDetailTokenColor(),
                  16.sp,
                  FontWeight.w400,
                ),
                styleRight: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16.sp,
                  FontWeight.w400,
                ),
              ),
              spaceH16,
              bothTxtFormAddFtAmount(
                txtLeft: S.current.ltv_liquid_thres,
                txtRight: '${formatValue.format(ltvLiquidThreshold)} %',
                styleLeft: textNormalCustom(
                  AppTheme.getInstance().currencyDetailTokenColor(),
                  16.sp,
                  FontWeight.w400,
                ),
                styleRight: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16.sp,
                  FontWeight.w400,
                ),
              ),
              spaceH16,
              bothTxtFormAddFtAmount(
                txtLeft: S.current.duration,
                txtRight: '${formatValue.format(duration)} months',
                styleLeft: textNormalCustom(
                  AppTheme.getInstance().currencyDetailTokenColor(),
                  16.sp,
                  FontWeight.w400,
                ),
                styleRight: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16.sp,
                  FontWeight.w400,
                ),
              ),
              spaceH16,
              bothTxtFormAddFtAmount(
                txtLeft: S.current.repayment_curr,
                txtRight: '$repaymentCurrent',
                styleLeft: textNormalCustom(
                  AppTheme.getInstance().currencyDetailTokenColor(),
                  16.sp,
                  FontWeight.w400,
                ),
                styleRight: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16.sp,
                  FontWeight.w400,
                ),
              ),
              spaceH16,
              bothTxtFormAddFtAmount(
                txtLeft: S.current.recurring_interest,
                txtRight: '$recurringInterest',
                styleLeft: textNormalCustom(
                  AppTheme.getInstance().currencyDetailTokenColor(),
                  16.sp,
                  FontWeight.w400,
                ),
                styleRight: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16.sp,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Row bothTxtFormAddFtAmount({
    required String txtLeft,
    required String txtRight,
    required TextStyle styleLeft,
    required TextStyle styleRight,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            txtLeft,
            style: styleLeft,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            txtRight,
            style: styleRight,
          ),
        )
      ],
    );
  }
}

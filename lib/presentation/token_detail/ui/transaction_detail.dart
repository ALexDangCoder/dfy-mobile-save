import 'dart:developer';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/transaction.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/hard_nft_screen.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/views/default_sub_screen.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransactionDetail extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetail({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultSubScreen(
      title: S.current.detail_transaction,
      mainWidget: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 24.h,
                bottom: 16.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textRow(
                        name: S.current.amount,
                        value: transaction.amount.stringIntFormat,
                      ),
                      transactionStatsWidget(transaction.status),
                    ],
                  ),
                  textRow(
                    name: S.current.gas_fee,
                    value: customCurrency(
                      amount: transaction.amount / 123654,
                      digit: 8,
                      type: 'BNB',
                    ),
                  ),
                  textRow(
                    name: S.current.time,
                    value: transaction.time.stringFromDateTime,
                  ),
                ],
              ),
            ),
            Divider(
              color: AppTheme.getInstance().divideColor(),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 24.h,
                bottom: 16.h,
              ),
              child: Column(
                children: [
                  textRow(
                    name: S.current.txh_id,
                    value: transaction.txhId,
                    showCopy: true,
                  ),
                  textRow(
                    name: S.current.from,
                    value: transaction.from.formatAddress,
                  ),
                  textRow(
                    name: S.current.to,
                    value: transaction.to,
                    showCopy: true,
                  ),
                ],
              ),
            ),
            Divider(
              color: AppTheme.getInstance().divideColor(),
            ),
            Container(
              padding: EdgeInsets.only(top: 16.h, bottom: 36.h),
              child: textRow(
                name: S.current.nonce,
                value: '#${transaction.nonce}',
              ),
            ),
            GestureDetector(
              onTap: () {
                log('On tap View on Bscscan');
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return HardNFTScreen(bloc: HardNFTBloc(),isAuction: true,);
                  },
                );
              },
              child: Text(
                S.current.view_on_bscscan,
                style: tokenDetailAmount(
                  fontSize: 16,
                  weight: FontWeight.w400,
                  color: AppTheme.getInstance().blueColor(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget transactionStatsWidget(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.SUCCESS:
        return textRow(
          name: S.current.status,
          value: S.current.transaction_success,
          valueColor: AppTheme.getInstance().successTransactionColors(),
        );
      case TransactionStatus.FAILED:
        return textRow(
          name: S.current.status,
          value: S.current.transaction_fail,
          valueColor: AppTheme.getInstance().failTransactionColors(),
        );
      case TransactionStatus.PENDING:
        return textRow(
          name: S.current.status,
          value: S.current.transaction_pending,
          valueColor: AppTheme.getInstance().pendingTransactionColors(),
        );
      default:
        return textRow(
          name: S.current.status,
          value: S.current.transaction_fail,
          valueColor: AppTheme.getInstance().failTransactionColors(),
        );
    }
  }

  Widget textRow({
    required String name,
    required String value,
    Color? valueColor,
    bool showCopy = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Text(
            '$name : ',
            style: tokenDetailAmount(
              color: AppTheme.getInstance().currencyDetailTokenColor(),
              fontSize: 14,
            ),
          ),
          Text(
            showCopy ? value.formatAddress : value,
            style: tokenDetailAmount(
              color: valueColor ?? AppTheme.getInstance().textThemeColor(),
              fontSize: 14,
              weight: FontWeight.w400,
            ),
          ),
          if (showCopy)
            SizedBox(
              width: 22.h,
            ),
          if (showCopy)
            InkWell(
              onTap: () {
                FlutterClipboard.copy(value);
                Fluttertoast.showToast(
                  msg: S.current.copy,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                );
              },
              child: SizedBox(
                height: 20.h,
                width: 20.h,
                child: Image.asset(
                  ImageAssets.ic_copy,
                  fit: BoxFit.fill,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/model/transaction_history_detail.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/views/default_sub_screen.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransactionHistoryDetailScreen extends StatelessWidget {
  final TokenDetailBloc bloc;
  final String status;
  final TransactionHistoryDetail transaction;

  const TransactionHistoryDetailScreen({
    Key? key,
    required this.bloc,
    required this.status,
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
                        value: transaction.amount.toString(),
                      ),
                      transactionStatsWidget(status),
                    ],
                  ),
                  textRow(
                    name: S.current.gas_fee,
                    value: customCurrency(
                      amount: transaction.gasFee,
                      digit: 8,
                      type: 'BNB',
                    ),
                  ),
                  textRow(
                    name: S.current.time,
                    value: DateTime.parse(transaction.time ?? '')
                        .stringFromDateTime,
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
                    value: transaction.txhId ?? '',
                    showCopy: true,
                  ),
                  textRow(
                    name: S.current.from,
                    value: transaction.from?.formatAddress ?? '',
                  ),
                  textRow(
                    name: S.current.to,
                    value: transaction.from ?? '',
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
              },
              child: Text(
                S.current.view_on_bscscan,
                style: tokenDetailAmount(
                  fontSize: 16,
                  color: AppTheme.getInstance().blueColor(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget transactionStatsWidget(String status) {
    switch (status) {
      case 'success':
        return textRow(
          name: S.current.status,
          value: S.current.transaction_success,
          valueColor: AppTheme.getInstance().successTransactionColors(),
        );
      case 'fail':
        return textRow(
          name: S.current.status,
          value: S.current.transaction_fail,
          valueColor: AppTheme.getInstance().failTransactionColors(),
        );
      default:
        return textRow(
          name: S.current.status,
          value: S.current.transaction_pending,
          valueColor: AppTheme.getInstance().pendingTransactionColors(),
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

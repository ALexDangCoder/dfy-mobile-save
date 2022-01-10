import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_history_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionHistoryDetailScreen extends StatelessWidget {
  final DetailHistoryTransaction transaction;
  final String shortName;

  const TransactionHistoryDetailScreen({
    Key? key,
    required this.transaction,
    required this.shortName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: S.current.detail_transaction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 24.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textRow(
                        name: S.current.amount,
                        value: '${transaction.quantity ?? 0} $shortName',
                      ),
                      transactionStatsWidget(transaction.status ?? ''),
                    ],
                  ),
                  textRow(
                    name: S.current.gas_fee,
                    value: transaction.gasFee ?? '',
                  ),
                  textRow(
                    name: S.current.time,
                    value: DateTime.parse(
                      transaction.dateTime ?? DateTime.now().toString(),
                    ).stringFromDateTime,
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
                    value: transaction.txhID ?? '',
                    showCopy: true,
                  ),
                  textRow(
                    name: S.current.from,
                    value: transaction.walletAddress?.formatAddress() ?? '',
                  ),
                  textRow(
                    name: S.current.to,
                    value: transaction.toAddress ?? '',
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
              onTap: () async {
                final String url =
                    'https://bscscan.com/tx/${transaction.txhID ?? ''}';
                await launch(url);
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
      case '1':
        return textRow(
          name: S.current.status,
          value: S.current.transaction_success,
          valueColor: AppTheme.getInstance().successTransactionColors(),
          needSize: false,
        );
      case '0':
        return textRow(
          name: S.current.status,
          value: S.current.transaction_fail,
          valueColor: AppTheme.getInstance().failTransactionColors(),
          needSize: false,
        );
      default:
        return textRow(
          name: S.current.status,
          value: S.current.transaction_pending,
          valueColor: AppTheme.getInstance().pendingTransactionColors(),
          needSize: false,
        );
    }
  }

  Widget textRow({
    required String name,
    required String value,
    Color? valueColor,
    bool showCopy = false,
    bool needSize = true,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          SizedBox(
            width: needSize ? 70.w : null,
            child: Text(
              '$name : ',
              style: tokenDetailAmount(
                color: AppTheme.getInstance().currencyDetailTokenColor(),
                fontSize: 14,
              ),
            ),
          ),
          Text(
            showCopy ? value.formatAddress() : value,
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

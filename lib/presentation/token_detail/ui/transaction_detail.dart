import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/views/default_sub_screen.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransactionDetail extends StatelessWidget {
  final String detailTransaction;

  const TransactionDetail({Key? key, required this.detailTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int amount = 1000635;
    final double gasFee = 0.0000454546;
    final DateTime _time = DateTime.now();
    final String txhID = '0xaaa042c0632f4d44c7cea978f22cd02e751a410e';
    final int nonce = 351;
    const isSuccess = true;
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
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: textRow(
                          name: S.current.amount,
                          value: amount.stringIntFormat,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: isSuccess
                              ? textRow(
                                  name: S.current.status,
                                  value: S.current.transaction_success,
                                  valueColor: AppTheme.getInstance()
                                      .successTransactionColors(),
                                )
                              : textRow(
                                  name: S.current.status,
                                  value: S.current.transaction_fail,
                                  valueColor: AppTheme.getInstance()
                                      .failTransactionColors(),
                                ),
                        ),
                      ),
                    ],
                  ),
                  textRow(
                    name: S.current.gas_fee,
                    value: customCurrency(
                      amount: gasFee,
                      digit: 8,
                      type: 'BNB',
                    ),
                  ),
                  textRow(
                    name: S.current.time,
                    value: _time.stringFromDateTime,
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
                    value: txhID,
                    showCopy: true,
                  ),
                  textRow(
                    name: S.current.from,
                    value: txhID.formatAddress,
                  ),
                  textRow(
                    name: S.current.to,
                    value: txhID,
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
                value: '#$nonce',
              ),
            ),
            GestureDetector(
              onTap: () {
                log('On tap View on Bscscan');
              },
              child: Text(
                S.current.view_on_bscscan,
                style: tokenDetailAmount(
                  fontSize: 16.h,
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
              fontSize: 14.h,
            ),
          ),
          Text(
            showCopy ? value.formatAddress : value,
            style: tokenDetailAmount(
              color: valueColor ?? AppTheme.getInstance().textThemeColor(),
              fontSize: 16.h,
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

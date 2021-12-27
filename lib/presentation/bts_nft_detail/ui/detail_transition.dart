import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_history_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionDetail extends StatelessWidget {
  final DetailHistoryTransaction obj;

  const TransactionDetail({Key? key, required this.obj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? gasFee = obj.gasFee;
    final String? _time = obj.dateTime;
    final String? txhID = obj.txhID;
    final String? nonce = obj.nonce;
    final String? isSuccess = obj.status;
    return BaseBottomSheet(
      title: S.current.detail_transaction,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textRow(
                      name: S.current.quantity,
                      value: '1 ${S.current.of_all} ${obj.quantity}',
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: isSuccess == STATUS_TRANSACTION_SUCCESS
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
                  value: _time ?? '',
                ),
              ],
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
                    value: txhID ?? '',
                    showCopy: true,
                  ),
                  textRow(
                    name: S.current.from,
                    value: txhID?.formatAddress() ?? '',
                  ),
                  textRow(
                    name: S.current.to,
                    value: txhID ?? '',
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
                launch('$BSC_SCAN$txhID');
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
            showCopy ? value.formatAddress() : value,
            style: tokenDetailAmount(
              color: valueColor ?? AppTheme.getInstance().textThemeColor(),
              fontSize: 16,
            ),
          ),
          if (showCopy)
            SizedBox(
              width: 20.h,
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

import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String des =
        'Kidzone ride on is the perfect gift for your child for any'
        'occasion. Adjustable seat belt to ensure security during '
        'driving. Rechargeable battery with 40-50 mins playtime.'
        'Charing time: 8-10 hours,'
        'Product Dimension (Inch): 42.52" x 24.41" x 15.75';
    const String address = '0xaaa042c0632f4d44c7cea978f22cd02e751a410e';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: tokenDetailAmount(
            color: AppTheme.getInstance().currencyDetailTokenColor(),
            weight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        spaceH5,
        Text(
          des,
          style: tokenDetailAmount(
            color: AppTheme.getInstance().currencyDetailTokenColor(),
            weight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        spaceH12,
        textRow(name: 'Collection', value: 'Defi For You'),
        textRow(name: 'Owner', value: address, isAddress: true),
        textRow(name: 'Contract', value: address, showCopy: true),
        textRow(name: 'NFT Token ID', value: '1452361'),
        textRow(name: 'NFT standard', value: 'ERC - 1155'),
        Text(
          'Block chain',
          style: tokenDetailAmount(
            color: AppTheme.getInstance().currencyDetailTokenColor(),
            weight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget textRow({
    required String name,
    required String value,
    Color? valueColor,
    bool showCopy = false,
    bool isAddress = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: tokenDetailAmount(
                color: AppTheme.getInstance().currencyDetailTokenColor(),
                weight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
          if (showCopy)
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      log('OnTap Address');
                    },
                    child: Text(
                      value.formatAddress,
                      style: tokenDetailAmount(
                        color: AppTheme.getInstance().blueColor(),
                        fontSize: 14,
                        weight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  spaceW8,
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
            )
          else
            Expanded(
              flex: 3,
              child: Text(
                isAddress ? value.formatAddress : value,
                style: tokenDetailAmount(
                  color: valueColor ?? AppTheme.getInstance().textThemeColor(),
                  fontSize: 14,
                  weight: FontWeight.w400,
                  decoration: isAddress
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

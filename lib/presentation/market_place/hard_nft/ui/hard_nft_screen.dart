import 'dart:developer';

import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/setting_wallet/ui/components/button_form.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_nft_market.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HardNFTScreen extends StatelessWidget {
  const HardNFTScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int month = 2;
    const String des =
        'Kidzone ride on is the perfect gift for your child for any'
        'occasion. Adjustable seat belt to ensure security during '
        'driving. Rechargeable battery with 40-50 mins playtime.'
        'Charing time: 8-10 hours,'
        'Product Dimension (Inch): 42.52" x 24.41" x 15.75';
    const String address = '0xaaa042c0632f4d44c7cea978f22cd02e751a410e';
    return BaseNFTMarket(
      filterFunc: filterFunc,
      title: 'Lamborghini Aventador Pink Ver 2021',
      image:
          'https://phelieuminhhuy.com/wp-content/uploads/2015/07/7f3ce033-b9b2-4259-ba7c-f6e5bae431a9-1435911423691.jpg',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expected loan',
                style: whiteTextWithOpacity,
              ),
              Row(
                children: [
                  sizedSvgImage(
                    w: 20,
                    h: 20,
                    image: ImageAssets.ic_token_dfy_svg,
                  ),
                  Text(
                    ' ${20000.stringIntFormat} DFY',
                    style: tokenDetailAmount(fontSize: 20),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '~ \$${1000.stringIntFormat}',
                style: whiteTextWithOpacity,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.duration,
                style: whiteTextWithOpacity,
              ),
              Text(
                '$month ${(month <= 1) ? S.current.month : S.current.months}',
                style: tokenDetailAmount(fontSize: 16),
              ),
            ],
          ),
          spaceH24,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonGradient(
                gradient: RadialGradient(
                  center: const Alignment(0.5, -0.5),
                  radius: 4,
                  colors: AppTheme.getInstance().gradientButtonColor(),
                ),
                onPressed: () {},
                child: Text(
                  S.current.send_offer,
                  style: tokenDetailAmount(
                    fontSize: 16,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          spaceH20,
          line,
          spaceH12,
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
      ),
    );
  }

  void filterFunc() {
    log('AAAAA');
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

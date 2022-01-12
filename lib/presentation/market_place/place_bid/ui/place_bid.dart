import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/confirm_blockchain_category.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceBid extends StatefulWidget {
  const PlaceBid({Key? key}) : super(key: key);

  @override
  _PlaceBidState createState() => _PlaceBidState();
}

class _PlaceBidState extends State<PlaceBid> {
  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: S.current.place_a_bid,
      isImage: true,
      text: ImageAssets.ic_close,
      onRightClick: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          children: [
            spaceH56,
            _buildRow(S.current.reserve_price, '\$95,000'),
            spaceH8,
            _buildRow(S.current.price_step, '59x22'),
            spaceH8,
            _buildRow(S.current.your_balance_bid, '35,000 DFY'),
            spaceH16,
            _currentBid,
            spaceH5,
            _cardCurrentBid('35000 DFY', ImageAssets.ic_token_dfy_svg, 'DFY'),
            spaceH344,
            _spaceButton(context),
          ],
        ),
      ),
    );
  }

  final Widget _currentBid = Align(
    alignment: Alignment.centerLeft,
    child: Text(
      S.current.current_bid,
      style: textNormalCustom(
        AppTheme.getInstance().textThemeColor(),
        16,
        FontWeight.w600,
      ),
    ),
  );

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textNormalCustom(
            AppTheme.getInstance().textThemeColor().withOpacity(0.7),
            16,
            FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: textNormalCustom(
            AppTheme.getInstance().textThemeColor(),
            16,
            FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _cardCurrentBid(String value, String assets, String nameToken) {
    return Container(
      height: 64.h,
      width: 343.w,
      padding: EdgeInsets.only(
        top: 22.h,
        bottom: 22.h,
        left: 22.w,
        right: 22.w,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w600,
            ),
          ),
          Row(
            children: [
              sizedSvgImage(w: 16, h: 16, image: assets),
              spaceW4,
              Text(
                nameToken,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _spaceButton(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: ButtonGradient(
          gradient: RadialGradient(
            center: const Alignment(0.5, -0.5),
            radius: 4,
            colors: AppTheme.getInstance().gradientButtonColor(),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConfirmBlockchainCategory(
                  nameWallet: 'nameWalletllllllllllllàafwf',
                  nameTokenWallet: 'BNB',
                  balanceWallet: 0.5,
                  typeConfirm: TYPE_CONFIRM.PLACE_BID,
                  addressFrom: '0xaB05Ab79C0F440ad982B1405536aBc8094C80AfB',
                  addressTo: '0xaB05Ab79C0F440ad982B1405536aBc8094C80AfB',
                  imageWallet: ImageAssets.image_avatar,
                  cubitCategory: PlaceBid(),
                  gasPriceFirstFetch: 0.5 / 1000000000,
                  gasFeeFirstFetch: 0.5 / 1000000000,
                  gasLimitFirstFetch: 0.5 / 1000000000,
                  amount: 0,
                ),
              ),
            );
          },
          child: Text(
            S.current.place_a_bid,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              20,
              FontWeight.w700,
            ),
          ),
        ),
      );
}

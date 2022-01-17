import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferDetailScreen extends StatelessWidget {
  const OfferDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      bottomBar: Container(
        padding: EdgeInsets.only(bottom: 38.h, right: 16.w, left: 16.w),

        color: AppTheme.getInstance().bgBtsColor(),
        child: Row(
          children: [
            Expanded(child: _buildButtonReject(context)),
            spaceW25,
            Expanded(child: _buildButtonAccept(context)),
          ],
        ),
      ),
      title: S.current.offer_detail,
      isImage: true,
      text: ImageAssets.ic_close,
      onRightClick: () {},
      child: Column(
        children: [
          spaceH20,
          Text(
            '0x9f69a6cbe17d26d86df0fc216bf632083a02a135'.formatAddressWallet(),
            style: richTextWhite.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          spaceH8,
          _rowStar(100),
          spaceH18,
          _textButton(),
          Divider(
            color: AppTheme.getInstance().divideColor(),
          ),
          spaceH20,
          ..._buildTable,
        ],
      ),
    );
  }

  List<Widget> get _buildTable => [
        buildRowCustom(
          title: '${S.current.status}:',
          child: Text(
            'Open',
            style: textNormalCustom(
              AppTheme.getInstance().blueColor(),
              16,
              FontWeight.w600,
            ),
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: '${S.current.message}:',
          child: Text(
            'Some thing went wrong',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: S.current.loan_amount,
          child: Row(
            children: [
              Image.asset(ImageAssets.ic_tick_circle),
              Text(
                '1000 BNB',
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: S.current.interest_rate,
          child: Text(
            '45%',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: S.current.recurring_interest,
          child: Text(
            'monthly',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: '${S.current.repayment_token}:',
          child: Row(
            children: [
              Image.asset(ImageAssets.ic_tick_circle),
              Text(
                'DFY',
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: S.current.duration,
          child: Text(
            '6 months',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: '${S.current.offer_create_by_day}:',
          child: Text(
            '10/05/2021',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
      ];

  Widget _rowStar(int mark) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.ic_star),
          spaceW12,
          Text(
            '$mark',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              32,
              FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textButton() {
    return TextButton(
        onPressed: () {},
        child: Text(
          S.current.view_profile,
          style: textNormalCustom(
            AppTheme.getInstance().fillColor(),
            16,
            FontWeight.normal,
          ),
        ),);
  }

  Widget _buildButtonReject(BuildContext context) {
    return ButtonTransparent(
      child: Text(
        S.current.reject,
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          16,
          FontWeight.w700,
        ),
      ),
      onPressed: () {},
    );
  }

  Widget _buildButtonAccept(BuildContext context) {
    return ButtonGradient(
      onPressed: () {},
      gradient: RadialGradient(
        center: const Alignment(0.5, -0.5),
        radius: 4,
        colors: AppTheme.getInstance().gradientButtonColor(),
      ),
      child: Text(
        S.current.accept,
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          16,
          FontWeight.w700,
        ),
      ),
    );
  }
}

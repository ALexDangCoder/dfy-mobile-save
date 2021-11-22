import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/place_bit_bts.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/tab_bar_controller.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/count_down_view/ui/nft_countdownn.dart';
import 'package:Dfy/widgets/nft_detail/nft_detail.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnAuction extends StatelessWidget {
  const OnAuction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDetailNFT(
      title: 'Naruto Dattebayo',
      url:
          'https://toigingiuvedep.vn/wp-content/uploads/2021/06/hinh-anh-naruto-chat-ngau-dep.jpg',
      children: [
        _priceContainer(),
        _timeContainer(),
        spaceH24,
        _buildButtonPlaceBid(context),
        spaceH20,
        _buildButtonBuyOut(context),
        spaceH18,
        divide,
        _buildTable(),
        spaceH20,
        divide,
        const AuctionTabBar(),
      ],
    );
  }

  Widget _buildButtonPlaceBid(BuildContext context) {
    return ButtonGradient(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return const PlaceBid();
          },
        );
      },
      gradient: RadialGradient(
        center: const Alignment(0.5, -0.5),
        radius: 4,
        colors: AppTheme.getInstance().gradientButtonColor(),
      ),
      child: Text(
        S.current.place_a_bid,
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          16,
          FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildButtonBuyOut(BuildContext context) {
    return ButtonTransparent(
      child: Text(
        S.current.buy_out,
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          16,
          FontWeight.w700,
        ),
      ),
      onPressed: () {},
    );
  }

  Widget _buildTable() => Column(
        children: [
          _desColumn(
            S.current.description,
            'Pharetra etiam libero erat in sit risus at vestibulum '
            'nulla. Cras enim nulla neque mauris. Mollis eu lorem '
            'lectus egestas maecenas mattis id convallis imperdiet.`',
          ),
          spaceH12,
          buildRow(
            title: S.current.collection,
            detail: 'DeFi For You',
            type: TextType.NORMAL,
          ),
          spaceH12,
          buildRow(
            title: S.current.owner,
            detail: '0xd07dc4262...61d1d2430',
            type: TextType.RICH_WHITE,
          ),
          spaceH12,
          buildRow(
            title: S.current.contract,
            detail: '0xd07dc4262...61d1d2430',
            type: TextType.RICH_BLUE,
          ),
          spaceH12,
          buildRow(
            title: S.current.nft_token_id,
            detail: '554458',
            type: TextType.NORMAL,
          ),
          spaceH12,
          buildRow(
            title: S.current.nft_standard,
            detail: 'ERC-1155',
            type: TextType.NORMAL,
          ),
          spaceH12,
          buildRow(
            title: S.current.block_chain,
            detail: 'Smart chain',
            type: TextType.NORMAL,
          ),
        ],
      );

  Column _desColumn(String title, String detail) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //S.current.description,
            title,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor().withOpacity(0.7),
              14,
              FontWeight.w400,
            ),
          ),
          spaceH12,
          Text(
            detail,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              14,
              FontWeight.w400,
            ),
          ),
        ],
      );

  Container _priceContainer() => Container(
        width: 343.w,
        height: 64.h,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reserve price',
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                14,
                FontWeight.normal,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.c,
                  children: [
                    sizedSvgImage(
                      w: 20,
                      h: 20,
                      image: ImageAssets.ic_token_dfy_svg,
                    ),
                    spaceW4,
                    Text(
                      '30,000 DFY',
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        20,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  '~100,000,000',
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                    14,
                    FontWeight.normal,
                  ),
                ),
              ],
            )
          ],
        ),
      );

  SizedBox _timeContainer() => SizedBox(
        width: 343.w,
        height: 116.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Auction ends in:',
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                14,
                FontWeight.normal,
              ),
            ),
            const CountDownView(timeInMilliSecond: 1200000),
          ],
        ),
      );
}

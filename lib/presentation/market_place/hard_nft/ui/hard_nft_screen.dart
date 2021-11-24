import 'dart:developer';

import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/widget/bidding_widget.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/widget/description_widget.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/information_widget.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/related_document_widget.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/common_bts/base_nft_market.dart';
import 'package:Dfy/widgets/count_down_view/ui/nft_countdownn.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HardNFTScreen extends StatelessWidget {
  final HardNFTBloc bloc;
  final bool isAuction;

  const HardNFTScreen({Key? key, required this.bloc, required this.isAuction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int month = 2;
    const List<Tab> tabWithoutBiding = <Tab>[
      Tab(text: 'History'),
      Tab(text: 'Owner'),
      Tab(text: 'Evaluation'),
    ];
    const List<Tab> tabWithBiding = <Tab>[
      Tab(text: 'History'),
      Tab(text: 'Owner'),
      Tab(text: 'Evaluation'),
      Tab(text: 'Bidding'),
    ];
    return BaseNFTMarket(
      filterFunc: filterFunc,
      title: 'Lamborghini Aventador Pink Ver 2021',
      image:
          'https://phelieuminhhuy.com/wp-content/uploads/2015/07/7f3ce033-b9b2-4259-ba7c-f6e5bae431a9-1435911423691.jpg',
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isAuction ? 'Reserve Price' : 'Expected loan',
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
            if (isAuction)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Auction ends in: ',
                    style: whiteTextWithOpacity,
                  ),
                  spaceH12,
                  const CountDownView(timeInMilliSecond: 12000),
                  spaceH24,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonGradient(
                      gradient: RadialGradient(
                        center: const Alignment(0.5, -0.5),
                        radius: 4,
                        colors: AppTheme.getInstance().gradientButtonColor(),
                      ),
                      onPressed: () {},
                      child: Text(
                        S.current.place_a_bid,
                        style: tokenDetailAmount(
                          fontSize: 16,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  spaceH24,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonTransparent(
                      onPressed: () {},
                      child: Text(
                        S.current.buy_out,
                        style: tokenDetailAmount(
                          fontSize: 16,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              )
            else
              Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonGradient(
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
                  ),
                  spaceH24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.duration,
                        style: whiteTextWithOpacity,
                      ),
                      Text(
                        '$month ${(month <= 1) ?
                        S.current.month :
                        S.current.months}',
                        style: tokenDetailAmount(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            spaceH20,
            line,
            spaceH12,
            const DescriptionWidget(),
            line,
            BiddingWidget(
              bloc: bloc,
              tabList: isAuction ? tabWithBiding : tabWithoutBiding,
            ),
          ],
        ),
      ),
    );
  }

  void filterFunc() {
    log('AAAAA');
  }
}

import 'dart:developer';

import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/bidding_widget.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/description_widget.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_nft_market.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';

class HardNFTScreen extends StatelessWidget {
  final HardNFTBloc bloc;
  const HardNFTScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int month = 2;
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
          const DescriptionWidget(),
          line,
          BiddingWidget(bloc: bloc,),
        ],
      ),
    );
  }

  void filterFunc() {
    log('AAAAA');
  }
}

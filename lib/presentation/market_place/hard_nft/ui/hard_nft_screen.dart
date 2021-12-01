import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/hard_nft/hard_nft_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/bidding_tab.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/evaluation_tab.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/history_tab.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/owners_tab.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/widget/description_widget.dart';
import 'package:Dfy/presentation/nft_on_pawn/ui/send_offer/send_offer.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/common_bts/base_nft_market.dart';
import 'package:Dfy/widgets/count_down_view/ui/nft_countdownn.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HardNFTScreen extends StatefulWidget {
  final HardNFTBloc bloc;
  final HardNFTModel hardNFT;

  const HardNFTScreen({
    Key? key,
    required this.bloc,
    required this.hardNFT,
  }) : super(key: key);

  @override
  State<HardNFTScreen> createState() => _HardNFTScreenState();
}

class _HardNFTScreenState extends State<HardNFTScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late List<Tab> tabList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabList = widget.hardNFT.isAuction
        ? <Tab>[
            Tab(text: S.current.history),
            Tab(text: S.current.owners),
            Tab(text: S.current.evaluation),
            Tab(text: S.current.bidding),
          ]
        : <Tab>[
            Tab(text: S.current.history),
            Tab(text: S.current.owner),
            Tab(text: S.current.evaluation),
          ];
    _tabController = TabController(
      length: tabList.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    const int month = 2;
    return BaseNFTMarket(
      title: widget.hardNFT.name,
      image: widget.hardNFT.image,
      filterFunc: () {},
      flagFunc: () {},
      shareFunc: () {},
      tabBar: TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 2.w),
        onTap: (i) {},
        controller: _tabController,
        tabs: tabList,
        indicatorColor: AppTheme.getInstance().unselectedTabLabelColor(),
        unselectedLabelColor: AppTheme.getInstance().unselectedTabLabelColor(),
        labelColor: AppTheme.getInstance().whiteColor(),
        labelStyle: unselectLabel,
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.hardNFT.isAuction
            ? listTabWithBidding()
            : listTabWithoutBidding(),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.hardNFT.isAuction
                      ? S.current.reserve_price
                      : S.current.expected_loan,
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
                      ' ${(widget.hardNFT.isAuction ? widget.hardNFT.reservePrice : widget.hardNFT.loan).stringIntFormat} DFY',
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
            if (widget.hardNFT.isAuction)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.auction_end_in,
                    style: whiteTextWithOpacity,
                  ),
                  spaceH12,
                  CountDownView(
                    timeInMilliSecond: widget.hardNFT.endTime
                        .difference(DateTime.now())
                        .inSeconds,
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.duration,
                        style: whiteTextWithOpacity,
                      ),
                      Text(
                        '${widget.hardNFT.duration} '
                        '${(widget.hardNFT.duration <= 1) ? S.current.month : S.current.months}',
                        style: tokenDetailAmount(fontSize: 16),
                      ),
                    ],
                  ),
                  spaceH24,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonGradient(
                      gradient: RadialGradient(
                        center: const Alignment(0.5, -0.5),
                        radius: 4,
                        colors: AppTheme.getInstance().gradientButtonColor(),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.black,
                          isScrollControlled: true,
                          context: context,
                          builder: (_) {
                            return const SendOffer();
                          },
                        );
                      },
                      child: Text(
                        S.current.send_offer,
                        style: tokenDetailAmount(
                          fontSize: 16,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            spaceH20,
            line,
            spaceH12,
            const DescriptionWidget(),
            spaceH20,
            line,
          ],
        ),
      ),
    );
  }

  List<Widget> listTabWithBidding() {
    return [
      HistoryTabContent(
        object: S.current.history,
      ),
      OwnersTabContent(
        object: S.current.owners,
      ),
      EvaluationTab(
        bloc: widget.bloc,
        evaluationModel: widget.hardNFT.evaluation,
      ),
      BidingTab(bloc: widget.bloc),
    ];
  }

  List<Widget> listTabWithoutBidding() {
    return [
      HistoryTabContent(
        object: S.current.history,
      ),
      OwnersTabContent(
        object: S.current.owners,
      ),
      EvaluationTab(
        bloc: widget.bloc,
        evaluationModel: widget.hardNFT.evaluation,
      ),
    ];
  }
}

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/bid_tab.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/history_tab.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/owner_tab.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/place_bit_bts.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/common_bts/base_nft_market.dart';
import 'package:Dfy/widgets/count_down_view/ui/nft_countdownn.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnAuction extends StatefulWidget {
  const OnAuction({Key? key}) : super(key: key);

  @override
  _OnAuctionState createState() => _OnAuctionState();
}

class _OnAuctionState extends State<OnAuction>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<Widget> tabPage = const [
    HistoryTab(),
    OwnerTab(),
    BidTab(),
  ];
  final List<Tab> titTab = [
    Tab(
      text: S.current.history,
    ),
    Tab(
      text: S.current.owner,
    ),
    Tab(
      text: S.current.bidding,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BaseNFTMarket(
          title: 'Coin card',
          image: 'https://toigingiuvedep.vn/wp-content/uploads/2021/06/h'
              'inh-anh-naruto-chat-ngau-dep.jpg',
          filterFunc: () {},
          flagFunc: () {},
          shareFunc: () {},
          tabBar: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: AppTheme.getInstance().titleTabColor(),
            indicatorColor: AppTheme.getInstance().titleTabColor(),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            tabs: titTab,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: TabBarView(
              controller: _tabController,
              children: tabPage,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
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
                spaceH24,
                divide,
              ],
            ),
          ),
        ),
      ),
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
            detail:
                '0xffffadakakdwqiacmaciqwmcacmiacmaciwcmascmia'.handleString(),
            type: TextType.RICH_WHITE,
          ),
          spaceH12,
          buildRow(
            title: S.current.contract,
            detail: '0xffffadakakdwqiacmaciqwmcacmiacmaciwcmascmia',
            type: TextType.RICH_BLUE,
            isShowCopy: true,
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
        padding: EdgeInsets.only(top: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.reserve_price,
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

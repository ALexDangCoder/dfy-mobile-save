import 'package:Dfy/config/base/base_custom_scroll_view.dart';
import 'package:Dfy/config/resources/dimen.dart';
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
import 'package:Dfy/widgets/button/round_button.dart';
import 'package:Dfy/widgets/count_down_view/ui/nft_countdownn.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String EXAMPLE_TITLE = 'Coin Card';
const String EXAMPLE_IMAGE_URL =
    'https://toigingiuvedep.vn/wp-content/uploads/2021/06/h'
    'inh-anh-naruto-chat-ngau-dep.jpg';

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
    return BaseCustomScrollView(
      bottomBar: Row(
        children: [
          Expanded(child: _buildButtonBuyOut(context)),
          spaceW25,
          Expanded(child: _buildButtonPlaceBid(context)),
        ],
      ),
      title: EXAMPLE_TITLE,
      image: EXAMPLE_IMAGE_URL,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: roundButton(image: ImageAssets.ic_btn_back_svg),
        ),
      ),
      initHeight: 360.h,
      content: [
        _cardTitle(title: EXAMPLE_TITLE),
        _priceContainer(),
        _timeContainer(),
        spaceH18,
        divide,
        _buildTable(),
        spaceH24,
        divide,
      ],
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
      tabBarView: TabBarView(
        controller: _tabController,
        children: tabPage,
      ),
    );
  }

  Widget _cardTitle({required String title, int quantity = 1}) {
    return Container(
      margin: EdgeInsets.only(
        top: 8.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  EXAMPLE_TITLE,
                  style: textNormalCustom(null, 24, FontWeight.w600),
                ),
              ),
              //todo when has feature backend
              // SizedBox(
              //   width: 25.h,
              // ),
              // InkWell(
              //   onTap: () {},
              //   child: roundButton(
              //     image: ImageAssets.ic_flag_svg,
              //     whiteBackground: true,
              //   ),
              // ),
              // SizedBox(
              //   width: 20.h,
              // ),
              // InkWell(
              //   onTap: () {},
              //   child: roundButton(
              //     image: ImageAssets.ic_share_svg,
              //     whiteBackground: true,
              //   ),
              // ),
            ],
          ),
          Text(
            '1 of $quantity available',
            textAlign: TextAlign.left,
            style: tokenDetailAmount(
              fontSize: 16,
            ),
          ),
          spaceH12,
          line,
        ],
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

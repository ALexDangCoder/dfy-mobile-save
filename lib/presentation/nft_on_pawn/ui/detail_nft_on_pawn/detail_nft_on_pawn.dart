import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/history_tab.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/owner_tab.dart';
import 'package:Dfy/presentation/nft_on_pawn/ui/send_offer/send_offer.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_nft_market.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnPawn extends StatefulWidget {
  const OnPawn({Key? key}) : super(key: key);

  @override
  _OnPawnState createState() => _OnPawnState();
}

class _OnPawnState extends State<OnPawn> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<Widget> tabPage = const [
    HistoryTab(),
    OwnerTab(),
  ];
  final List<Tab> titTab = [
    Tab(
      child: Text(
        S.current.history,
        style: textNormalCustom(
          AppTheme.getInstance().titleTabColor(),
          14,
          FontWeight.w600,
        ),
      ),
    ),
    Tab(
      child: Text(
        S.current.owner,
        style: textNormalCustom(
          AppTheme.getInstance().titleTabColor(),
          14,
          FontWeight.w600,
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BaseNFTMarket(
          title: 'Sasuke',
          image:
              'https://ss-images.saostar.vn/wwebp700/pc/1594115439836/GBESLN61nS1w0'
              '7Anv557R8r0CQ2jziDhfZA0691LdBwlv1554468007730compressflag.png',
          flagFunc: () {},
          filterFunc: () {},
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
                _durationRow(),
                spaceH24,
                _buildButtonSendOffer(context),
                spaceH20,
                // _buildButtonBuyOut(context),
                spaceH18,
                divide,
                _buildTable(),
                spaceH20,
                divide,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSendOffer(BuildContext context) {
    return ButtonGradient(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return const SendOffer();
            },
          ),
        );
      },
      gradient: RadialGradient(
        center: const Alignment(0.5, -0.5),
        radius: 4,
        colors: AppTheme.getInstance().gradientButtonColor(),
      ),
      child: Text(
        S.current.send_offer,
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          16,
          FontWeight.w700,
        ),
      ),
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

  Row _durationRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.current.duration,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor().withOpacity(0.7),
              14,
              FontWeight.normal,
            ),
          ),
          Text(
            '12 ${S.current.month}',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w600,
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
              S.current.expected_loan,
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
                Expanded(
                  child: Text(
                    '~100,000,000',
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                      14,
                      FontWeight.normal,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
}

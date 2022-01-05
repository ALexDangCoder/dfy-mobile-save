import 'package:Dfy/config/base/base_custom_scroll_view.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/main_screen/buy_nft/ui/buy_nft.dart';
import 'package:Dfy/presentation/market_place/place_bid/ui/place_bid.dart';
import 'package:Dfy/presentation/market_place/send_offer/send_offer.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/bid_tab.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/history_tab.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/offer_tab.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/owner_tab.dart';
import 'package:Dfy/presentation/offer_detail/ui/offer_detail_screen.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/button/round_button.dart';
import 'package:Dfy/widgets/count_down_view/ui/nft_countdownn.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String EXAMPLE_TITLE = 'Naruto kkcam allfp lflll alffwl c ';
const String EXAMPLE_IMAGE_URL =
    'https://toigingiuvedep.vn/wp-content/uploads/2021/06/h'
    'inh-anh-naruto-chat-ngau-dep.jpg';
final auctionObj = NFTOnAuction(
  EXAMPLE_IMAGE_URL,
  EXAMPLE_TITLE,
  300000,
  'ERC-721',
  '0xaB05Ab79C0F440ad982B1405536aBc8094C80AfB',
  'BDA collection',
  '30',
  '30',
  'Binance Smart chain',
  1,
  300000,
  true,
  [
    Properties('tag', 'Heaven'),
    Properties('Nam', 'Nguyen Thanh Nam'),
    Properties('face', 'No 1 vietnam')
  ],
  'Pharetra etiam libero erat in sit risus at vestibulum nulla. Cras enim nulla neque mauris. Mollis eu lorem '
      'lectus egestas maecenas mattis id convallis imperdiet.`',
);

class NFTDetailScreen extends StatefulWidget {
  const NFTDetailScreen({Key? key, required this.type,  this.marketId})
      : super(key: key);
  final MarketType type;
  final String? marketId;

  @override
  _NFTDetailScreenState createState() => _NFTDetailScreenState();
}

class _NFTDetailScreenState extends State<NFTDetailScreen>
    with SingleTickerProviderStateMixin {
  late final Widget _price;
  late final Widget _duration;
  late final Widget _bottomBar;
  late final List<Widget> _tabPage;
  late final List<Widget> _tabTit;
  late final TabController _tabController;
  late final NFTDetailBloc _bloc;

  void caseWidget() {
    switch (widget.type) {
      case MarketType.AUCTION:
        _price = _priceContainerOnAuction(30000);
        _duration = _timeContainer(30000);
        _tabPage = const [
          HistoryTab(
            listHistory: [],
          ),
          OwnerTab(),
          BidTab(),
        ];
        _tabTit = [
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
        _bottomBar = Row(
          children: [
            Expanded(child: _buildButtonBuyOut(context)),
            spaceW25,
            Expanded(child: _buildButtonPlaceBid(context)),
          ],
        );
        break;
      case MarketType.SALE:
        _price = _priceContainerOnSale();
        _duration = Container();
        _tabPage = const [
          HistoryTab(
            listHistory: [],
          ),
          OwnerTab(),
        ];
        _tabTit = [
          Tab(
            text: S.current.history,
          ),
          Tab(
            text: S.current.owner,
          ),
        ];
        _bottomBar = _buildButtonBuyOutOnSale(context);
        break;
      case MarketType.PAWN:
        _price = _priceContainerOnPawn();
        _duration = _durationRowOnPawn();
        _tabPage = const [
          HistoryTab(
            listHistory: [],
          ),
          OwnerTab(),
          OfferTab(),
        ];
        _tabTit = [
          Tab(
            text: S.current.history,
          ),
          Tab(
            text: S.current.owner,
          ),
          Tab(
            text: S.current.offer,
          ),
        ];
        _bottomBar = _buildButtonSendOffer(context);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    caseWidget();
    _tabController = TabController(length: _tabPage.length, vsync: this);
    _bloc = NFTDetailBloc();
    _bloc.getInForNFT(widget.marketId ?? '', widget.type);
  }

  @override
  void dispose() {
    _bloc.close();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseCustomScrollView(
      image: EXAMPLE_IMAGE_URL,
      initHeight: 360.h,
      leading: _leading(),
      title: EXAMPLE_TITLE,
      tabBarView: TabBarView(
        controller: _tabController,
        children: _tabPage,
      ),
      tabBar: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.getInstance().titleTabColor(),
        indicatorColor: AppTheme.getInstance().titleTabColor(),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        tabs: _tabTit,
      ),
      bottomBar: _bottomBar,
      content: [
        _cardTitle(title: EXAMPLE_TITLE),
        _price,
        _duration,
        divide,
        spaceH12,
        _description(
          'Pharetra etiam libero erat in sit risus at vestibulum '
          'nulla. Cras enim nulla neque mauris. Mollis eu lorem lectus egestas '
          'maecenas mattis id convallis imperdiet.',
        ),
        spaceH20,
        StreamBuilder<bool>(
          initialData: false,
          stream: _bloc.viewStream,
          builder: (context, snapshot) {
            return Visibility(
              visible: !snapshot.data!,
              child: Column(
                children: [
                  _rowCollection('DFY', auctionObj.collectionName ?? '', true),
                  spaceH20,
                  additionalColumn(auctionObj.properties ?? []),
                  spaceH20,
                  _buildTable(),
                  spaceH12,
                ],
              ),
            );
          },
        ),
        StreamBuilder<bool>(
          initialData: true,
          stream: _bloc.viewStream,
          builder: (context, snapshot) {
            return Visibility(
              child: InkWell(
                onTap: () {
                  _bloc.viewSink.add(!snapshot.data!);
                },
                child: Container(
                  padding: EdgeInsets.only(
                    right: 16.w,
                    left: 16.w,
                  ),
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sizedSvgImage(
                        w: 14,
                        h: 14,
                        image: !snapshot.data!
                            ? ImageAssets.ic_collapse_svg
                            : ImageAssets.ic_expand_svg,
                      ),
                      SizedBox(
                        width: 13.15.w,
                      ),
                      Text(
                        !snapshot.data!
                            ? S.current.view_less
                            : S.current.view_more,
                        style: textNormalCustom(
                          AppTheme.getInstance().fillColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        divide,
      ],
    );
  }

  Widget _leading() => InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: roundButton(image: ImageAssets.ic_btn_back_svg),
        ),
      );

  Widget _cardTitle({required String title}) {
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
                  title,
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
            '1 of 1 available',
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const PlaceBid();
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OfferDetailScreen(),
          ),
        );
      },
    );
  }

  Widget _description(String des) {
    return Text(
      des,
      style: textNormalCustom(
        AppTheme.getInstance().textThemeColor(),
        14,
        FontWeight.w400,
      ),
    );
  }

  Widget _buildTable() => Column(
        children: [
          buildRow(
            title: S.current.collection_address,
            detail: 'auctionObj.collectionAddress',
            type: TextType.RICH_BLUE,
            isShowCopy: true,
          ),
          spaceH12,
          buildRow(
            title: S.current.nft_id,
            detail: 'auctionObj.nftId',
            type: TextType.NORMAL,
          ),
          spaceH12,
          buildRow(
            title: S.current.nft_standard,
            detail: 'auctionObj.nftStandard',
            type: TextType.NORMAL,
          ),
          spaceH12,
          buildRow(
            title: S.current.block_chain,
            detail: 'auctionObj.blockChain',
            type: TextType.NORMAL,
          ),
        ],
      );

  Widget additionalColumn(List<Properties> properties) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.additional,
          style: textNormalCustom(
            AppTheme.getInstance().textThemeColor(),
            16,
            FontWeight.w600,
          ),
        ),
        spaceH14,
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            children: properties
                .map(
                  (e) => SizedBox(
                    height: 50.h,
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppTheme.getInstance()
                              .divideColor()
                              .withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      backgroundColor: AppTheme.getInstance().bgBtsColor(),
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.key ?? '',
                            textAlign: TextAlign.left,
                            style: textNormalCustom(
                              AppTheme.getInstance()
                                  .textThemeColor()
                                  .withOpacity(0.7),
                              12,
                              FontWeight.w400,
                            ),
                          ),
                          spaceH4,
                          Text(
                            e.value ?? '',
                            textAlign: TextAlign.left,
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              14,
                              FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }

  Widget _rowCollection(String symbol, String collectionName, bool verify) {
    return Row(
      children: [
        SizedBox(
          height: 28.h,
          width: 28.w,
          child: CircleAvatar(
            backgroundColor: Colors.yellow,
            radius: 18.r,
            child: Center(
              child: Text(
                symbol.substring(0, 1),
                style: textNormalCustom(
                  Colors.black,
                  20,
                  FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          collectionName,
          style: textNormalCustom(
            Colors.white,
            16,
            FontWeight.w400,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        if (verify) ...[
          sizedSvgImage(w: 16.w, h: 16.h, image: ImageAssets.ic_verify_svg)
        ]
      ],
    );
  }

  Container _priceContainerOnAuction(double price) => Container(
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
                      '$price DFY',
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

  Container _priceContainerOnSale() => Container(
        width: 343.w,
        height: 64.h,
        margin: EdgeInsets.only(top: 12.h),
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

  Container _priceContainerOnPawn() => Container(
        width: 343.w,
        height: 50.h,
        margin: EdgeInsets.only(top: 12.h),
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

  Widget _durationRowOnPawn() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${S.current.duration}:',
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
          ),
          spaceH12,
        ],
      );

  SizedBox _timeContainer(int milliSecond) => SizedBox(
        width: 343.w,
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
            spaceH16,
            CountDownView(timeInMilliSecond: milliSecond),
            spaceH24,
          ],
        ),
      );

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

  Widget _buildButtonBuyOutOnSale(BuildContext context) {
    return ButtonGradient(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return const BuyNFT();
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
        S.current.buy_nft,
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          16,
          FontWeight.w700,
        ),
      ),
    );
  }
}

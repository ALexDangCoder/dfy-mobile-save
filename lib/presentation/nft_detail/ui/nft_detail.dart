import 'dart:async';
import 'dart:developer';

import 'package:Dfy/config/base/base_custom_scroll_view.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/main_screen/buy_nft/ui/buy_nft.dart';
import 'package:Dfy/presentation/market_place/cancel_sale/bloc/cancel_sale_cubit.dart';
import 'package:Dfy/presentation/market_place/cancel_sale/ui/cancel_sale.dart';
import 'package:Dfy/presentation/market_place/place_bid/ui/place_bid.dart';
import 'package:Dfy/presentation/market_place/send_offer/send_offer.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_state.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/bid_tab.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/history_tab.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/offer_tab.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/owner_tab.dart';
import 'package:Dfy/presentation/offer_detail/ui/offer_detail_screen.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/button/round_button.dart';
import 'package:Dfy/widgets/count_down_view/ui/nft_countdownn.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/modal_progress_hud.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import '../../../main.dart';

class NFTDetailScreen extends StatefulWidget {
  const NFTDetailScreen({
    Key? key,
    required this.type,
    this.marketId,
  }) : super(key: key);
  final MarketType type;
  final String? marketId;

  @override
  _NFTDetailScreenState createState() => _NFTDetailScreenState();
}

class _NFTDetailScreenState extends State<NFTDetailScreen>
    with SingleTickerProviderStateMixin {
  late final List<Widget> _tabPage;
  late final List<Widget> _tabTit;
  late final TabController _tabController;
  late final NFTDetailBloc _bloc;

  void caseTabBar(MarketType type) {
    switch (type) {
      case MarketType.AUCTION:
        _tabPage = [
          StreamBuilder<List<HistoryNFT>>(
            stream: _bloc.listHistoryStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<HistoryNFT>> snapshot,
            ) {
              return HistoryTab(
                listHistory: snapshot.data ?? [],
              );
            },
          ),
          StreamBuilder<List<OwnerNft>>(
            stream: _bloc.listOwnerStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<OwnerNft>> snapshot,
            ) {
              return OwnerTab(
                listOwner: snapshot.data ?? [],
              );
            },
          ),
          StreamBuilder<List<BiddingNft>>(
            stream: _bloc.listBiddingStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<BiddingNft>> snapshot,
            ) {
              return BidTab(
                listBidding: snapshot.data ?? [],
                symbolToken: _bloc.symbolToken,
              );
            },
          ),
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
        break;
      case MarketType.SALE:
        _tabPage = [
          StreamBuilder<List<HistoryNFT>>(
            stream: _bloc.listHistoryStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<HistoryNFT>> snapshot,
            ) {
              return HistoryTab(
                listHistory: snapshot.data ?? [],
              );
            },
          ),
          StreamBuilder<List<OwnerNft>>(
            stream: _bloc.listOwnerStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<OwnerNft>> snapshot,
            ) {
              return OwnerTab(
                listOwner: snapshot.data ?? [],
              );
            },
          ),
        ];
        _tabTit = [
          Tab(
            text: S.current.history,
          ),
          Tab(
            text: S.current.owner,
          ),
        ];
        break;
      case MarketType.PAWN:
        _tabPage = [
          HistoryTab(
            listHistory: [],
          ),
          OwnerTab(
            listOwner: [],
          ),
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
        break;
      default:
        break;
    }
  }

  final formatUSD = NumberFormat('\$ ###,###,###.###', 'en_US');

  @override
  void initState() {
    super.initState();
    _bloc = NFTDetailBloc();
    _bloc.getInForNFT(widget.marketId ?? '', widget.type);
    caseTabBar(widget.type);
    _tabController = TabController(length: _tabPage.length, vsync: this);
    trustWalletChannel
        .setMethodCallHandler(_bloc.nativeMethodCallBackTrustWallet);
    _bloc.getDataString(
      orderId: '88',
      walletAddress: '0x39ee4c28e09ce6d908643dddeeaeef2341138ebb',
      context: context,
    );
    _bloc.getGasLimit(
      walletAddress: '',
    );
  }

  @override
  void dispose() {
    _bloc.close();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NFTDetailBloc, NFTDetailState>(
      bloc: _bloc,
      builder: (context, state) {
        return _content(widget.type, state);
      },
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

  Widget _nameNFT({
    required String title,
    int quantity = 1,
    String url = '',
    double? price,
  }) {
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
              SizedBox(
                width: 25.h,
              ),
              InkWell(
                onTap: () async {
                  final navigator = Navigator.of(context);
                  //todo

                  unawaited(
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => CancelSale(
                          bloc: _bloc,
                        ),
                      ),
                    ),
                  );
                },
                child: roundButton(
                  image: ImageAssets.ic_flag_svg,
                  whiteBackground: true,
                ),
              ),
              SizedBox(
                width: 20.h,
              ),
              InkWell(
                onTap: () {
                  Share.share(url, subject: 'Buy NFT with $price USD');
                },
                child: roundButton(
                  image: ImageAssets.ic_share_svg,
                  whiteBackground: true,
                ),
              ),
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        des.parseHtml(),
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          14,
          FontWeight.w400,
        ),
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
          child: properties.isEmpty
              ? Text(
                  S.current.no_more_info,
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    14,
                    FontWeight.w400,
                  ),
                )
              : Wrap(
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
                            backgroundColor:
                                AppTheme.getInstance().bgBtsColor(),
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

  Container _priceContainerOnAuction({
    required double price,
    String shortName = 'DFY',
    String urlToken = '',
    double usdExchange = 0,
  }) =>
      Container(
        width: 343.w,
        height: 64.h,
        margin: EdgeInsets.only(top: 12.h),
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
                  children: [
                    if (urlToken.isNotEmpty)
                      Image(
                        image: NetworkImage(
                          urlToken,
                        ),
                        width: 20.w,
                        height: 20.h,
                      )
                    else
                      Image(
                        image: const AssetImage(ImageAssets.symbol),
                        width: 20.w,
                        height: 20.h,
                      ),
                    spaceW4,
                    Text(
                      '$price $shortName',
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
                    formatUSD.format(price * usdExchange),
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

  Container _priceContainerOnSale({
    required double price,
    String shortName = 'DFY',
    String urlToken = '',
    double usdExchange = 0,
  }) =>
      Container(
        width: 343.w,
        height: 64.h,
        margin: EdgeInsets.only(top: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.price,
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
                    if (urlToken.isNotEmpty)
                      Image(
                        image: NetworkImage(
                          urlToken,
                        ),
                        width: 20.w,
                        height: 20.h,
                      )
                    else
                      Image(
                        image: const AssetImage(ImageAssets.symbol),
                        width: 20.w,
                        height: 20.h,
                      ),
                    spaceW4,
                    Text(
                      '$price $shortName',
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
                    formatUSD.format(price * usdExchange),
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

  SizedBox _timeContainer(int second) => SizedBox(
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
            CountDownView(timeInMilliSecond: second),
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

  Widget _content(MarketType type, NFTDetailState state) {
    switch (type) {
      case MarketType.SALE:
        if (state is NftOnSaleSuccess) {
          final objSale = state.nftMarket;
          return StateStreamLayout(
            stream: _bloc.stateStream,
            error:
                AppException(S.current.error, S.current.something_went_wrong),
            retry: () async {
              await _bloc.getInForNFT(widget.marketId ?? '', widget.type);
            },
            textEmpty: '',
            child: BaseCustomScrollView(
              typeImage: objSale.typeImage,
              image: objSale.image,
              initHeight: 360.h,
              leading: _leading(),
              title: objSale.name,
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
              bottomBar: _buildButtonBuyOutOnSale(context),
              content: [
                _nameNFT(
                  title: objSale.name,
                  quantity: objSale.totalCopies ?? 1,
                  url: objSale.image,
                  price: objSale.price * (objSale.usdExchange ?? 1),
                ),
                _priceContainerOnSale(
                  price: objSale.price,
                  usdExchange: objSale.usdExchange ?? 0,
                  urlToken: objSale.urlToken ?? '',
                  shortName: objSale.symbolToken ?? '',
                ),
                divide,
                spaceH12,
                _description(
                  objSale.description?.isEmpty ?? true
                      ? S.current.no_des
                      : objSale.description ?? S.current.no_des,
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
                          if (objSale.collectionName?.isEmpty ?? true)
                            const SizedBox()
                          else
                            _rowCollection(
                              'DFY',
                              objSale.collectionName ?? '',
                              objSale.ticked == 1,
                            ),
                          spaceH20,
                          additionalColumn(objSale.properties ?? []),
                          spaceH20,
                          ...[
                            buildRow(
                              title: S.current.collection_address,
                              detail: objSale.collectionAddress ?? '',
                              type: TextType.RICH_BLUE,
                              isShowCopy: true,
                            ),
                            spaceH12,
                            buildRow(
                              title: S.current.nft_token_id,
                              detail: objSale.nftTokenId ?? '',
                              type: TextType.NORMAL,
                            ),
                            spaceH12,
                            buildRow(
                              title: S.current.nft_standard,
                              detail: objSale.nftStandard ?? '',
                              type: TextType.NORMAL,
                            ),
                            spaceH12,
                            buildRow(
                              title: S.current.block_chain,
                              detail: 'Binance smart chain',
                              type: TextType.NORMAL,
                            ),
                          ],
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
            ),
          );
        } else {
          return const ModalProgressHUD(
            inAsyncCall: true,
            progressIndicator: CupertinoLoading(),
            child: SizedBox(),
          );
        }
      case MarketType.PAWN:
        return BaseCustomScrollView(
          image: '',
          initHeight: 360.h,
          leading: _leading(),
          title: '',
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
          bottomBar: Container(),
          content: [
            _nameNFT(title: ''),
            Container(),
            Container(),
            divide,
            spaceH12,
            Container(),
            spaceH20,
            StreamBuilder<bool>(
              initialData: false,
              stream: _bloc.viewStream,
              builder: (context, snapshot) {
                return Visibility(
                  visible: !snapshot.data!,
                  child: Column(
                    children: [
                      _rowCollection('DFY', 'n', true),
                      spaceH20,
                      additionalColumn([]),
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
      case MarketType.AUCTION:
        if (state is NftOnAuctionSuccess) {
          final nftOnAuction = state.nftOnAuction;
          return StateStreamLayout(
            stream: _bloc.stateStream,
            error:
                AppException(S.current.error, S.current.something_went_wrong),
            retry: () async {
              await _bloc.getInForNFT(widget.marketId ?? '', widget.type);
            },
            textEmpty: '',
            child: BaseCustomScrollView(
              image: nftOnAuction.fileCid ?? '',
              initHeight: 360.h,
              leading: _leading(),
              title: nftOnAuction.name ?? '',
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
              bottomBar: Row(
                children: [
                  Expanded(
                    child: _buildButtonBuyOut(context),
                  ),
                  SizedBox(
                    width: 23.w,
                  ),
                  Expanded(
                    child: _buildButtonPlaceBid(context),
                  ),
                ],
              ),
              content: [
                _nameNFT(
                  title: nftOnAuction.name ?? '',
                  quantity: nftOnAuction.numberOfCopies ?? 1,
                  url: nftOnAuction.fileCid ?? '',
                  price: (nftOnAuction.reservePrice ?? 0) *
                      (nftOnAuction.usdExchange ?? 1),
                ),
                _priceContainerOnAuction(
                  price: nftOnAuction.reservePrice ?? 0,
                  usdExchange: nftOnAuction.usdExchange ?? 0,
                  urlToken: nftOnAuction.urlToken ?? '',
                  shortName: nftOnAuction.tokenSymbol ?? '',
                ),
                _timeContainer(_bloc.getTimeCountDown(nftOnAuction)),
                divide,
                spaceH12,
                _description(
                  nftOnAuction.description?.isEmpty ?? true
                      ? S.current.no_des
                      : nftOnAuction.description ?? S.current.no_des,
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
                          _rowCollection(
                            'DFY',
                            nftOnAuction.collectionName ?? '',
                            true,
                          ),
                          spaceH20,
                          additionalColumn(nftOnAuction.properties ?? []),
                          spaceH20,
                          buildRow(
                            title: S.current.collection_address,
                            detail: nftOnAuction.collectionAddress ?? '',
                            type: TextType.RICH_BLUE,
                            isShowCopy: true,
                          ),
                          spaceH12,
                          buildRow(
                            title: S.current.nft_token_id,
                            detail: nftOnAuction.nftTokenId ?? '',
                            type: TextType.NORMAL,
                          ),
                          spaceH12,
                          buildRow(
                            title: S.current.nft_standard,
                            detail: nftOnAuction.nftStandard ?? '',
                            type: TextType.NORMAL,
                          ),
                          spaceH12,
                          buildRow(
                            title: S.current.block_chain,
                            detail: 'Binance smart chain',
                            type: TextType.NORMAL,
                          ),
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
            ),
          );
        } else {
          return const ModalProgressHUD(
            inAsyncCall: true,
            progressIndicator: CupertinoLoading(),
            child: SizedBox(),
          );
        }
      default:
        return Container();
    }
  }
}

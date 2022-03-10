import 'dart:async';

import 'package:Dfy/config/base/base_custom_scroll_view.dart';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';
import 'package:Dfy/domain/model/offer_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/buy_nft/ui/buy_nft.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/evaluation_tab.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_state.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/bid_tab.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/history_tab.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/offer_tab.dart';
import 'package:Dfy/presentation/nft_detail/ui/tab_page/owner_tab.dart';
import 'package:Dfy/presentation/place_bid/ui/place_bid.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:Dfy/presentation/put_on_market/ui/put_on_market_screen.dart';
import 'package:Dfy/presentation/send_offer/ui/send_offer.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_nft/send_nft.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/base_items/base_fail.dart';
import 'package:Dfy/widgets/base_items/base_success.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:Dfy/widgets/button/round_button.dart';
import 'package:Dfy/widgets/count_down_view/ui/nft_countdownn.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/modal_progress_hud.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/coming_soon.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

part 'auction.dart';

part 'component.dart';

part 'pawn.dart';

part 'sale.dart';

final nftKey = GlobalKey<NFTDetailScreenState>();

class NFTDetailScreen extends StatefulWidget {
  const NFTDetailScreen({
    Key? key,
    required this.typeMarket,
    this.marketId,
    this.typeNft,
    this.nftId,
    this.pawnId,
    this.nftTokenId,
    this.collectionAddress,
    this.pageRouter,
  }) : super(key: key);
  final MarketType typeMarket;
  final TypeNFT? typeNft;
  final String? marketId;
  final String? nftTokenId;
  final String? collectionAddress;
  final String? nftId;
  final int? pawnId;
  final PageRouter? pageRouter;

  @override
  NFTDetailScreenState createState() => NFTDetailScreenState();
}

class NFTDetailScreenState extends State<NFTDetailScreen>
    with SingleTickerProviderStateMixin {
  late final List<Widget> _tabPage;
  late final List<Widget> _tabTit;
  late final TabController _tabController;
  late final String walletAddress;
  final PageController pageController = PageController();
  final NFTDetailBloc bloc = NFTDetailBloc();

  @override
  void initState() {
    super.initState();
    trustWalletChannel
        .setMethodCallHandler(bloc.nativeMethodCallBackTrustWallet);
    caseTabBar(widget.typeMarket, widget.typeNft);
    onRefresh();
    _tabController = TabController(length: _tabPage.length, vsync: this);
  }

  void caseTabBar(MarketType type, TypeNFT? typeNft) {
    switch (type) {
      case MarketType.AUCTION:
        _tabPage = [
          StreamBuilder<List<HistoryNFT>>(
            stream: bloc.listHistoryStream,
            builder: (
              context,
              AsyncSnapshot<List<HistoryNFT>> snapshot,
            ) {
              if (snapshot.hasData) {
                return HistoryTab(
                  listHistory: snapshot.data ?? [],
                );
              } else {
                return SizedBox(
                  height: 100.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: AppTheme.getInstance().whiteColor(),
                    ),
                  ),
                );
              }
            },
          ),
          StreamBuilder<List<OwnerNft>>(
            stream: bloc.listOwnerStream,
            builder: (
              context,
              AsyncSnapshot<List<OwnerNft>> snapshot,
            ) {
              if (snapshot.hasData) {
                return OwnerTab(
                  listOwner: snapshot.data ?? [],
                );
              } else {
                return SizedBox(
                  height: 100.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: AppTheme.getInstance().whiteColor(),
                    ),
                  ),
                );
              }
            },
          ),
          if (widget.typeNft == TypeNFT.HARD_NFT)
            StreamBuilder<Evaluation>(
              stream: bloc.evaluationStream,
              builder: (
                context,
                AsyncSnapshot<Evaluation> snapshot,
              ) {
                if (snapshot.hasData) {
                  return EvaluationTab(
                    evaluation: snapshot.data ?? Evaluation(),
                  );
                } else {
                  return SizedBox(
                    height: 100.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.r,
                        color: AppTheme.getInstance().whiteColor(),
                      ),
                    ),
                  );
                }
              },
            ),
          StreamBuilder<List<BiddingNft>>(
            stream: bloc.listBiddingStream,
            builder: (
              context,
              AsyncSnapshot<List<BiddingNft>> snapshot,
            ) {
              if (snapshot.hasData) {
                return BidTab(
                  listBidding: snapshot.data ?? [],
                  symbolToken: bloc.symbolToken,
                );
              } else {
                return SizedBox(
                  height: 100.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: AppTheme.getInstance().whiteColor(),
                    ),
                  ),
                );
              }
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
          if (widget.typeNft == TypeNFT.HARD_NFT)
            Tab(
              text: S.current.evaluation,
            ),
          Tab(
            text: S.current.bidding,
          ),
        ];
        break;
      case MarketType.SALE:
      case MarketType.NOT_ON_MARKET:
        _tabPage = [
          StreamBuilder<List<HistoryNFT>>(
            stream: bloc.listHistoryStream,
            builder: (
              context,
              AsyncSnapshot<List<HistoryNFT>> snapshot,
            ) {
              if (snapshot.hasData) {
                return HistoryTab(
                  listHistory: snapshot.data ?? [],
                );
              } else {
                return SizedBox(
                  height: 100.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: AppTheme.getInstance().whiteColor(),
                    ),
                  ),
                );
              }
            },
          ),
          StreamBuilder<List<OwnerNft>>(
            stream: bloc.listOwnerStream,
            builder: (
              context,
              AsyncSnapshot<List<OwnerNft>> snapshot,
            ) {
              if (snapshot.hasData) {
                return OwnerTab(
                  listOwner: snapshot.data ?? [],
                );
              } else {
                return SizedBox(
                  height: 100.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: AppTheme.getInstance().whiteColor(),
                    ),
                  ),
                );
              }
            },
          ),
          if (widget.typeNft == TypeNFT.HARD_NFT)
            StreamBuilder<Evaluation>(
              stream: bloc.evaluationStream,
              builder: (
                context,
                AsyncSnapshot<Evaluation> snapshot,
              ) {
                if (snapshot.hasData) {
                  return EvaluationTab(
                    evaluation: snapshot.data ?? Evaluation(),
                  );
                } else {
                  return SizedBox(
                    height: 100.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.r,
                        color: AppTheme.getInstance().whiteColor(),
                      ),
                    ),
                  );
                }
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
          if (widget.typeNft == TypeNFT.HARD_NFT)
            Tab(
              text: S.current.evaluation,
            ),
        ];
        break;
      case MarketType.PAWN:
        _tabPage = [
          StreamBuilder<List<HistoryNFT>>(
            stream: bloc.listHistoryStream,
            builder: (
              context,
              AsyncSnapshot<List<HistoryNFT>> snapshot,
            ) {
              if (snapshot.hasData) {
                return HistoryTab(
                  listHistory: snapshot.data ?? [],
                );
              } else {
                return SizedBox(
                  height: 100.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: AppTheme.getInstance().whiteColor(),
                    ),
                  ),
                );
              }
            },
          ),
          StreamBuilder<List<OwnerNft>>(
            stream: bloc.listOwnerStream,
            builder: (
              context,
              AsyncSnapshot<List<OwnerNft>> snapshot,
            ) {
              if (snapshot.hasData) {
                return OwnerTab(
                  listOwner: snapshot.data ?? [],
                );
              } else {
                return SizedBox(
                  height: 100.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: AppTheme.getInstance().whiteColor(),
                    ),
                  ),
                );
              }
            },
          ),
          if (widget.typeNft == TypeNFT.HARD_NFT)
            StreamBuilder<Evaluation>(
              stream: bloc.evaluationStream,
              builder: (
                context,
                AsyncSnapshot<Evaluation> snapshot,
              ) {
                if (snapshot.data?.id!.isNotEmpty ?? false) {
                  return EvaluationTab(
                    evaluation: snapshot.data!,
                  );
                } else {
                  return Center(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 100.h),
                      children: [
                        Center(
                          child: sizedPngImage(
                            w: 94,
                            h: 94,
                            image: ImageAssets.icNoTransaction,
                          ),
                        ),
                        Center(
                          child: Text(
                            S.current.no_transaction,
                            style: tokenDetailAmount(
                              color: AppTheme.getInstance()
                                  .currencyDetailTokenColor(),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          StreamBuilder<List<OfferDetail>>(
            stream: bloc.listOfferStream,
            builder: (
              context,
              AsyncSnapshot<List<OfferDetail>> snapshot,
            ) {
              if (snapshot.hasData) {
                return OfferTab(
                  listOffer: snapshot.data ?? [],
                );
              } else {
                return SizedBox(
                  height: 100.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: AppTheme.getInstance().whiteColor(),
                    ),
                  ),
                );
              }
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
          if (widget.typeNft == TypeNFT.HARD_NFT)
            Tab(
              text: S.current.evaluation,
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

  @override
  void dispose() {
    bloc.close();
    _tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {
    await bloc.getInForNFT(
      marketId: widget.marketId ?? '',
      nftId: widget.nftId ?? '',
      pawnId: widget.pawnId ?? 0,
      type: widget.typeMarket,
      typeNFT: widget.typeNft ?? TypeNFT.SOFT_NFT,
      collectionAddress: widget.collectionAddress ?? '',
      nftTokenId: widget.nftTokenId ?? '',
    );
    await bloc.getListWallets();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NFTDetailBloc, NFTDetailState>(
      bloc: bloc,
      builder: (context, state) {
        return StateStreamLayout(
          stream: bloc.stateStream,
          error: AppException(S.current.error, S.current.something_went_wrong),
          retry: () async {
            await bloc.getInForNFT(
              marketId: widget.marketId ?? '',
              nftId: widget.nftId ?? '',
              type: widget.typeMarket,
              typeNFT: widget.typeNft ?? TypeNFT.SOFT_NFT,
              pawnId: widget.pawnId ?? 0,
              collectionAddress: widget.collectionAddress ?? '',
              nftTokenId: widget.nftTokenId ?? '',
            );
          },
          textEmpty: '',
          child: content(
            widget.typeMarket,
            state,
            pageRouter: widget.pageRouter,
          ),
        );
      },
    );
  }

  Widget content(MarketType type, NFTDetailState state,
      {PageRouter? pageRouter}) {
    switch (type) {
      case MarketType.NOT_ON_MARKET:
        if (state is NftNotOnMarketSuccess) {
          final objSale = state.nftMarket;
          return BaseCustomScrollView(
            typeImage: objSale.typeImage ?? TypeImage.IMAGE,
            image: objSale.image ?? '',
            initHeight: 360.h,
            leading: _leading(context),
            actions: [
              if (pageRouter == PageRouter.MY_ACC)
                action(
                  context,
                  objSale.collectionAddress ?? '',
                  objSale.isOwner ?? false,
                  objSale.nftTokenId ?? '',
                  objSale.walletAddress ?? '',
                  objSale.nftId ?? '',
                  bloc,
                  objSale,
                  onRefresh,
                ),
            ],
            title: objSale.name ?? '',
            tabBarView: ExpandedPageViewWidget(
              pageController: pageController,
              controller: _tabController,
              children: _tabPage,
            ),
            tabBar: TabBar(
              onTap: (value) {
                pageController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 5),
                  curve: Curves.ease,
                );
              },
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
            bottomBar: _buildButtonPutOnMarket(
              context,
              bloc,
              objSale,
              widget.nftId,
              onRefresh,
            ),
            content: [
              _nameNFT(
                context: context,
                title: objSale.name ?? '',
                quantity: objSale.totalCopies ?? 1,
                url: objSale.image ?? '',
                price: (objSale.price ?? 0) * (objSale.usdExchange ?? 1),
              ),
              _priceNotOnMarket(),
              divide,
              spaceH12,
              _description(
                objSale.description ?? '',
              ),
              spaceH20,
              StreamBuilder<bool>(
                initialData: false,
                stream: bloc.viewStream,
                builder: (context, snapshot) {
                  return Visibility(
                    visible: !snapshot.data!,
                    child: Column(
                      children: [
                        if (objSale.collectionName?.isEmpty ?? true)
                          const SizedBox()
                        else
                          _rowCollection(
                            objSale.collectionName ?? '',
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
                            detail:
                                objSale.nftStandard == '0' ? ERC_721 : ERC_1155,
                            type: TextType.NORMAL,
                          ),
                          spaceH12,
                          buildRow(
                            title: S.current.block_chain,
                            detail: BINANCE_SMART_CHAIN,
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
                stream: bloc.viewStream,
                builder: (context, snapshot) {
                  return Visibility(
                    child: InkWell(
                      onTap: () {
                        bloc.viewSink.add(!snapshot.data!);
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
                            Text(
                              !snapshot.data!
                                  ? S.current.see_less
                                  : S.current.see_more,
                              style: textNormalCustom(
                                AppTheme.getInstance().fillColor(),
                                16,
                                FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 13.15.w,
                            ),
                            sizedSvgImage(
                              w: 14,
                              h: 14,
                              image: !snapshot.data!
                                  ? ImageAssets.ic_collapse_svg
                                  : ImageAssets.ic_expand_svg,
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
        } else {
          return const ModalProgressHUD(
            inAsyncCall: true,
            progressIndicator: CupertinoLoading(),
            child: SizedBox(),
          );
        }
      case MarketType.SALE:
        if (state is NftOnSaleSuccess) {
          final objSale = state.nftMarket;
          return BaseCustomScrollView(
            typeImage: objSale.typeImage ?? TypeImage.IMAGE,
            image: objSale.image ?? '',
            initHeight: 360.h,
            leading: _leading(context),
            title: objSale.name ?? '',
            tabBarView: ExpandedPageViewWidget(
              pageController: pageController,
              controller: _tabController,
              children: _tabPage,
            ),
            tabBar: TabBar(
              onTap: (value) {
                pageController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 5),
                  curve: Curves.ease,
                );
              },
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
            bottomBar: objSale.owner?.toLowerCase() !=
                    PrefsService.getCurrentWalletCore().toLowerCase()
                ? _buildButtonBuy(
                    context,
                    bloc,
                    objSale,
                    objSale.isBoughtByOther ?? false,
                    widget.marketId ?? '',
                  )
                : _buildButtonCancelOnSale(
                    context,
                    bloc,
                    objSale,
                    onRefresh,
                  ),
            content: [
              _nameNFT(
                title: objSale.name ?? '',
                quantity: objSale.totalCopies ?? 1,
                url: objSale.image ?? '',
                price: (objSale.price ?? 0) * (objSale.usdExchange ?? 1),
                context: context,
              ),
              _priceContainerOnSale(
                price: objSale.price ?? 0,
                usdExchange: objSale.usdExchange ?? 0,
                urlToken: objSale.urlToken ?? '',
                shortName: objSale.symbolToken ?? '',
              ),
              divide,
              spaceH12,
              _description(
                objSale.description ?? '',
              ),
              spaceH20,
              StreamBuilder<bool>(
                initialData: false,
                stream: bloc.viewStream,
                builder: (context, snapshot) {
                  return Visibility(
                    visible: !snapshot.data!,
                    child: Column(
                      children: [
                        if (objSale.collectionName?.isEmpty ?? true)
                          const SizedBox()
                        else
                          _rowCollection(
                            objSale.token ?? '',
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
                            detail: BINANCE_SMART_CHAIN,
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
                stream: bloc.viewStream,
                builder: (context, snapshot) {
                  return Visibility(
                    child: InkWell(
                      onTap: () {
                        bloc.viewSink.add(!snapshot.data!);
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
                            Text(
                              !snapshot.data!
                                  ? S.current.see_less
                                  : S.current.see_more,
                              style: textNormalCustom(
                                AppTheme.getInstance().fillColor(),
                                16,
                                FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 13.15.w,
                            ),
                            sizedSvgImage(
                              w: 14,
                              h: 14,
                              image: !snapshot.data!
                                  ? ImageAssets.ic_collapse_svg
                                  : ImageAssets.ic_expand_svg,
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
        } else {
          return const ModalProgressHUD(
            inAsyncCall: true,
            progressIndicator: CupertinoLoading(),
            child: SizedBox(),
          );
        }
      case MarketType.PAWN:
        if (state is NftOnPawnSuccess) {
          final nftOnPawn = state.nftOnPawn;
          PrefsService.saveOwnerPawn(nftOnPawn.walletAddress ?? '');
          return BaseCustomScrollView(
            typeImage:
                nftOnPawn.nftCollateralDetailDTO?.typeImage ?? TypeImage.IMAGE,
            image: nftOnPawn.nftCollateralDetailDTO?.image ?? '',
            initHeight: 360.h,
            leading: _leading(context),
            title: nftOnPawn.nftCollateralDetailDTO?.nftName ?? '',
            tabBarView: ExpandedPageViewWidget(
              pageController: pageController,
              controller: _tabController,
              children: _tabPage,
            ),
            tabBar: TabBar(
              onTap: (value) {
                pageController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 5),
                  curve: Curves.ease,
                );
              },
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
            bottomBar: nftOnPawn.walletAddress?.toLowerCase() ==
                    PrefsService.getCurrentWalletCore().toLowerCase()
                ? _buildButtonCancelOnPawn(
                    context,
                    bloc,
                    nftOnPawn,
                    onRefresh,
                  )
                : _buildButtonSendOffer(context, nftOnPawn),
            content: [
              _nameNFT(
                url: nftOnPawn.nftCollateralDetailDTO?.image ?? '',
                context: context,
                title: nftOnPawn.nftCollateralDetailDTO?.nftName ?? '',
              ),
              _priceContainerOnPawn(nftOnPawn: nftOnPawn),
              _durationRowOnPawn(
                durationType: nftOnPawn.durationType ?? 0,
                durationQty: nftOnPawn.durationQuantity ?? 0,
              ),
              divide,
              spaceH12,
              _description(nftOnPawn.description ?? ''),
              spaceH20,
              StreamBuilder<bool>(
                initialData: false,
                stream: bloc.viewStream,
                builder: (context, snapshot) {
                  return Visibility(
                    visible: !snapshot.data!,
                    child: Column(
                      children: [
                        _rowCollection(
                          nftOnPawn.nftCollateralDetailDTO?.nameCollection ??
                              '',
                          nftOnPawn.nftCollateralDetailDTO?.nameCollection ??
                              '',
                          nftOnPawn.nftCollateralDetailDTO?.isWhitelist ??
                              false,
                        ),
                        spaceH20,
                        additionalColumn(
                          nftOnPawn.nftCollateralDetailDTO?.properties ?? [],
                        ),
                        spaceH20,
                        buildRow(
                          title: S.current.collection_address,
                          detail: nftOnPawn
                                  .nftCollateralDetailDTO?.collectionAddress ??
                              '',
                          type: TextType.RICH_BLUE,
                          isShowCopy: true,
                        ),
                        spaceH12,
                        buildRow(
                          title: S.current.nft_token_id,
                          detail: nftOnPawn.nftCollateralDetailDTO?.nftTokenId
                                  .toString() ??
                              '',
                          type: TextType.NORMAL,
                        ),
                        spaceH12,
                        buildRow(
                          title: S.current.nft_standard,
                          detail: (nftOnPawn.nftCollateralDetailDTO?.nftStandard
                                          .toString() ??
                                      '0') ==
                                  '0'
                              ? 'ERC - 721'
                              : 'ERC - 1155',
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
                stream: bloc.viewStream,
                builder: (context, snapshot) {
                  return Visibility(
                    child: InkWell(
                      onTap: () {
                        bloc.viewSink.add(!snapshot.data!);
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
                            Text(
                              !snapshot.data!
                                  ? S.current.see_less
                                  : S.current.see_more,
                              style: textNormalCustom(
                                AppTheme.getInstance().fillColor(),
                                16,
                                FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 13.15.w,
                            ),
                            sizedSvgImage(
                              w: 14,
                              h: 14,
                              image: !snapshot.data!
                                  ? ImageAssets.ic_collapse_svg
                                  : ImageAssets.ic_expand_svg,
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
        } else {
          return const ModalProgressHUD(
            inAsyncCall: true,
            progressIndicator: CupertinoLoading(),
            child: SizedBox(),
          );
        }
      case MarketType.AUCTION:
        if (state is NftOnAuctionSuccess) {
          final nftOnAuction = state.nftOnAuction;
          return BaseCustomScrollView(
            typeImage: nftOnAuction.typeImage ?? TypeImage.IMAGE,
            image: nftOnAuction.fileCid ?? '',
            initHeight: 360.h,
            leading: _leading(context),
            title: nftOnAuction.name ?? '',
            tabBarView: ExpandedPageViewWidget(
              pageController: pageController,
              controller: _tabController,
              children: _tabPage,
            ),
            tabBar: TabBar(
              onTap: (value) {
                pageController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 5),
                  curve: Curves.ease,
                );
              },
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
            bottomBar: (nftOnAuction.isOwner == true)
                ? buttonCancelAuction(
                    approveAdmin: nftOnAuction.show ?? true,
                    context: context,
                    bloc: bloc,
                    nftMarket: nftOnAuction,
                    refresh: onRefresh,
                  )
                : bloc.isStartAuction(nftOnAuction.endTime ?? 0)
                    ? Row(
                        children: [
                          Expanded(
                            child: _buildButtonBuyOut(
                              context,
                              nftOnAuction,
                              widget.marketId ?? '',
                              bloc.isStartAuction(
                                nftOnAuction.startTime ?? 0,
                              ),
                              bloc.isStartAuction(
                                nftOnAuction.endTime ?? 0,
                              ),
                              onRefresh,
                            ),
                          ),
                          SizedBox(
                            width: 23.w,
                          ),
                          Expanded(
                            child: _buildButtonPlaceBid(
                              context,
                              bloc.isStartAuction(
                                nftOnAuction.startTime ?? 0,
                              ),
                              bloc.isStartAuction(
                                nftOnAuction.endTime ?? 0,
                              ),
                              bloc,
                              nftOnAuction,
                              widget.marketId ?? '',
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
            content: [
              _nameNFT(
                context: context,
                title: nftOnAuction.name ?? '',
                quantity: nftOnAuction.numberOfCopies ?? 1,
                url: nftOnAuction.fileCid ?? '',
                price: (nftOnAuction.reservePrice ?? 0) *
                    (nftOnAuction.usdExchange ?? 1),
              ),
              _priceContainerOnAuction(
                nftOnAuction: nftOnAuction,
                isEnd: !bloc.isStartAuction(nftOnAuction.endTime ?? 0),
              ),
              _timeContainer(
                bloc.isStartAuction(nftOnAuction.startTime ?? 0),
                bloc.getTimeCountDown(nftOnAuction.startTime ?? 0),
                bloc.isStartAuction(nftOnAuction.endTime ?? 0),
                bloc.getTimeCountDown(nftOnAuction.endTime ?? 0),
                onRefresh,
              ),
              if (nftOnAuction.marketStatus == 9) waitingAcceptAuction(),
              divide,
              spaceH12,
              _description(
                nftOnAuction.description ?? '',
              ),
              spaceH20,
              StreamBuilder<bool>(
                initialData: false,
                stream: bloc.viewStream,
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
                stream: bloc.viewStream,
                builder: (context, snapshot) {
                  return Visibility(
                    child: InkWell(
                      onTap: () {
                        bloc.viewSink.add(!snapshot.data!);
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
                            Text(
                              !snapshot.data!
                                  ? S.current.see_less
                                  : S.current.see_more,
                              style: textNormalCustom(
                                AppTheme.getInstance().fillColor(),
                                16,
                                FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 13.15.w,
                            ),
                            sizedSvgImage(
                              w: 14,
                              h: 14,
                              image: !snapshot.data!
                                  ? ImageAssets.ic_collapse_svg
                                  : ImageAssets.ic_expand_svg,
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

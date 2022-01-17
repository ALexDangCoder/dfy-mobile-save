import 'package:Dfy/config/base/base_custom_scroll_view.dart';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';
import 'package:Dfy/domain/model/offer_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/main_screen/buy_nft/ui/buy_nft.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/evaluation_tab.dart';
import 'package:Dfy/presentation/market_place/login/ui/dialog/warrning_dialog.dart';
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
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/button/error_button.dart';
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
  }) : super(key: key);
  final MarketType typeMarket;
  final TypeNFT? typeNft;
  final String? marketId;
  final String? nftId;
  final int? pawnId;

  @override
  NFTDetailScreenState createState() => NFTDetailScreenState();
}

class NFTDetailScreenState extends State<NFTDetailScreen>
    with SingleTickerProviderStateMixin {
  late final List<Widget> _tabPage;
  late final List<Widget> _tabTit;
  late final TabController _tabController;
  late final NFTDetailBloc bloc;
  late final String walletAddress;

  @override
  void initState() {
    super.initState();
    bloc = NFTDetailBloc();
    trustWalletChannel
        .setMethodCallHandler(bloc.nativeMethodCallBackTrustWallet);
    bloc.nftMarketId = widget.marketId ?? '';
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
              return HistoryTab(
                listHistory: snapshot.data ?? [],
              );
            },
          ),
          StreamBuilder<List<OwnerNft>>(
            stream: bloc.listOwnerStream,
            builder: (
              context,
              AsyncSnapshot<List<OwnerNft>> snapshot,
            ) {
              return OwnerTab(
                listOwner: snapshot.data ?? [],
              );
            },
          ),
          if (widget.typeNft == TypeNFT.HARD_NFT)
            EvaluationTab(bloc: HardNFTBloc()),
          StreamBuilder<List<BiddingNft>>(
            stream: bloc.listBiddingStream,
            builder: (
              context,
              AsyncSnapshot<List<BiddingNft>> snapshot,
            ) {
              return BidTab(
                listBidding: snapshot.data ?? [],
                symbolToken: bloc.symbolToken,
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
        _tabPage = [
          StreamBuilder<List<HistoryNFT>>(
            stream: bloc.listHistoryStream,
            builder: (
              context,
              AsyncSnapshot<List<HistoryNFT>> snapshot,
            ) {
              return HistoryTab(
                listHistory: snapshot.data ?? [],
              );
            },
          ),
          StreamBuilder<List<OwnerNft>>(
            stream: bloc.listOwnerStream,
            builder: (
              context,
              AsyncSnapshot<List<OwnerNft>> snapshot,
            ) {
              return OwnerTab(
                listOwner: snapshot.data ?? [],
              );
            },
          ),
          if (widget.typeNft == TypeNFT.HARD_NFT)
            EvaluationTab(bloc: HardNFTBloc())
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
              return HistoryTab(
                listHistory: snapshot.data ?? [],
              );
            },
          ),
          StreamBuilder<List<OwnerNft>>(
            stream: bloc.listOwnerStream,
            builder: (
              context,
              AsyncSnapshot<List<OwnerNft>> snapshot,
            ) {
              return OwnerTab(
                listOwner: snapshot.data ?? [],
              );
            },
          ),
          if (widget.typeNft == TypeNFT.HARD_NFT)
            EvaluationTab(bloc: HardNFTBloc()),
          StreamBuilder<List<OfferDetail>>(
            stream: bloc.listOfferStream,
            builder: (
              context,
              AsyncSnapshot<List<OfferDetail>> snapshot,
            ) {
              return OfferTab(
                listOffer: snapshot.data ?? [],
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
    super.dispose();
  }

  Future<void> onRefresh() async {
    await bloc.getInForNFT(
      marketId: widget.marketId ?? '',
      nftId: widget.nftId ?? '',
      pawnId: widget.pawnId ?? 0,
      type: widget.typeMarket,
      typeNFT: widget.typeNft ?? TypeNFT.SOFT_NFT,
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
            );
          },
          textEmpty: '',
          child: _content(widget.typeMarket, state),
        );
      },
    );
  }

  Widget _content(MarketType type, NFTDetailState state) {
    switch (type) {
      case MarketType.SALE:
        if (state is NftOnSaleSuccess) {
          final objSale = state.nftMarket;
          return BaseCustomScrollView(
            typeImage: objSale.typeImage ?? TypeImage.IMAGE,
            image: objSale.image ?? '',
            initHeight: 360.h,
            leading: _leading(context),
            title: objSale.name ?? '',
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
            bottomBar: _buildButtonBuyOutOnSale(
              context,
              bloc,
              objSale.isBoughtByOther ?? false,
            ),
            content: [
              GestureDetector(
                //todo: để tạm, sau check quyền button cancel hoặc buy
                onTap: () async {
                  var nav = Navigator.of(context);
                  if (bloc.walletAddress.toLowerCase() ==
                      bloc.nftMarket.owner?.toLowerCase()) {
                    double gas =
                        await bloc.getGasLimitForCancel(context: context);
                    if (gas > 0) {
                      nav.push(
                        MaterialPageRoute(
                            builder: (context) => Approve(
                              hexString: bloc.hexString,
                                  listDetail: bloc.initListApprove(),
                                  title: S.current.cancel_sale,
                                  header: Container(
                                    padding: EdgeInsets.only(
                                      top: 16.h,
                                      bottom: 20.h,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      S.current.cancel_sale_info,
                                      style: textNormal(
                                        AppTheme.getInstance().whiteColor(),
                                        16,
                                      ).copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  warning: Row(
                                    children: [
                                      sizedSvgImage(
                                          w: 16.67.w,
                                          h: 16.67.h,
                                          image: ImageAssets.ic_warning_canel),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          S.current.customer_cannot,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: textNormal(
                                            AppTheme.getInstance()
                                                .currencyDetailTokenColor(),
                                            14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  textActiveButton: S.current.cancel_sale,
                                  gasLimitInit: double.parse(bloc.gasLimit),
                                  typeApprove: TYPE_CONFIRM_BASE.CANCEL_SALE,
                                )),
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => WarningDialog(
                        walletAdress: bloc.nftMarket.owner ?? '',
                      ),
                    );
                  }
                },
                child: _nameNFT(
                  title: objSale.name ?? '',
                  quantity: objSale.totalCopies ?? 1,
                  url: objSale.image ?? '',
                  price: (objSale.price ?? 0) * (objSale.usdExchange ?? 1),
                ),
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
                            objSale.symbolToken ?? '',
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
          return BaseCustomScrollView(
            typeImage:
                nftOnPawn.nftCollateralDetailDTO?.typeImage ?? TypeImage.IMAGE,
            image: nftOnPawn.nftCollateralDetailDTO?.image ?? '',
            initHeight: 360.h,
            leading: _leading(context),
            title: nftOnPawn.nftCollateralDetailDTO?.nftName ?? '',
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
            bottomBar: _buildButtonSendOffer(context),
            content: [
              _nameNFT(
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
                          'DFY',
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
                          detail:
                              (nftOnPawn.nftCollateralDetailDTO?.nftStandard ??
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
                  child: _buildButtonPlaceBid(
                    context,
                    bloc.isStartAuction(
                      nftOnAuction.startTime ?? 0,
                    ),
                    bloc.isStartAuction(
                      nftOnAuction.endTime ?? 0,
                    ),
                    bloc,
                  ),
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
                nftOnAuction: nftOnAuction,
                isEnd: !bloc.isStartAuction(nftOnAuction.endTime ?? 0),
              ),
              _timeContainer(
                bloc.isStartAuction(nftOnAuction.startTime ?? 0),
                bloc.getTimeCountDown(nftOnAuction.startTime ?? 0),
                bloc.isStartAuction(nftOnAuction.endTime ?? 0),
                bloc.getTimeCountDown(nftOnAuction.endTime ?? 0),
              ),
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

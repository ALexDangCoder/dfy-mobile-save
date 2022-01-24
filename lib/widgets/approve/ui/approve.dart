import 'dart:async';
import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/bid_nft_request.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/collection_list/ui/collection_list.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_fail.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_submit.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_success.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/bloc/approve_state.dart';
import 'package:Dfy/widgets/approve/extension/call_api_be.dart';
import 'package:Dfy/widgets/approve/extension/call_core_logic_extention.dart';
import 'package:Dfy/widgets/approve/extension/common_extension.dart';
import 'package:Dfy/widgets/approve/extension/get_gas_limit_extension.dart';
import 'package:Dfy/widgets/approve/ui/component/estimate_gas_fee.dart';
import 'package:Dfy/widgets/base_items/base_fail.dart';
import 'package:Dfy/widgets/base_items/base_success.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'component/pop_up_approve.dart';

///  Appbar                                   :                  title
///  Body                                     :                  header
///  render list key value from
///  List<DetailItemApproveModel>? listDetail :
///                                                         key  ---    value
///                                                           key -----    value
///                                                           key ----     value
///                                                             .... continue
///    Widget? warning;                       :                 warning
///                                                            Widget account
///                                                      Widget estimate gas fee
///
class Approve extends StatefulWidget {
  final String title;
  final List<DetailItemApproveModel>? listDetail;
  final Widget? warning;
  final Widget? header;
  final PutOnMarketModel? putOnMarketModel;
  final NftMarket? nftMarket;
  final bool? needApprove;
  final int? flexTitle;
  final int? flexContent;
  final String? purposeText;
  final String textActiveButton;
  final num? quantity;

  /// [gasLimitFirst] is min of gas limit
  final String? hexString;

  final TYPE_CONFIRM_BASE typeApprove;
  final CreateCollectionCubit? createCollectionCubit;
  final String? payValue;
  final String? tokenAddress;

  const Approve({
    Key? key,
    required this.title,
    this.listDetail,
    this.warning,
    this.needApprove = false,
    required this.textActiveButton,
    this.header,
    this.purposeText,
    this.flexTitle,
    this.flexContent,
    required this.typeApprove,
    this.createCollectionCubit,
    this.payValue,
    this.tokenAddress,
    this.hexString,
    this.putOnMarketModel,
    this.quantity,
    this.nftMarket,
  }) : super(key: key);

  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  late final ApproveCubit cubit;
  GlobalKey scaffoldKey = GlobalKey();
  double? heightScaffold;
  late int accountImage;
  double gasFee = 0;
  int nonce = 0;
  late final NFTDetailBloc nftDetailBloc;
  GlobalKey bottomKey = GlobalKey();
  double heightOfBottom = 0;

  void initData(TYPE_CONFIRM_BASE typeBase) {
    cubit.context = context;
    cubit.putOnMarketModel = widget.putOnMarketModel;
    cubit.needApprove = widget.needApprove ?? false;
    cubit.payValue = widget.payValue ?? '';
    cubit.tokenAddress = widget.tokenAddress ?? '';
    cubit.hexString = widget.hexString;
    switch (typeBase) {
      case TYPE_CONFIRM_BASE.BUY_NFT:
        nftDetailBloc = nftKey.currentState?.bloc ?? NFTDetailBloc();
        getNonce();
        break;
      case TYPE_CONFIRM_BASE.PLACE_BID:
        nftDetailBloc = nftKey.currentState?.bloc ?? NFTDetailBloc();
        getNonce();
        break;
      case TYPE_CONFIRM_BASE.CANCEL_SALE:
        nftDetailBloc = nftKey.currentState?.bloc ?? NFTDetailBloc();
        getNonce();
        break;
      case TYPE_CONFIRM_BASE.SEND_NFT:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.SEND_TOKEN:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.PUT_ON_SALE:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.SEND_OFFER:
        nftDetailBloc = nftKey.currentState?.bloc ?? NFTDetailBloc();
        getNonce();
        break;
      case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
        cubit.isSoftCollection =
            (widget.createCollectionCubit?.collectionType ?? 0) == 0;
        break;
      case TYPE_CONFIRM_BASE.CANCEL_AUCTION:
        nftDetailBloc = nftKey.currentState?.bloc ?? NFTDetailBloc();
        getNonce();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    cubit = ApproveCubit();
    cubit.type = widget.typeApprove;
    accountImage = cubit.randomAvatar();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      heightScaffold = scaffoldKey.currentContext?.size?.height;
      heightOfBottom = bottomKey.currentContext?.size?.height ?? 0;
      setState(() {});
    });

    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);

    /// get wallet information
    cubit.getListWallets();
    initData(widget.typeApprove);
  }

  Future<void> getNonce() async {
    nonce = await nftDetailBloc.getNonceWeb3();
  }

  /// Function approve

  Future<void> approve() async {
    bool isShowLoading = false;
    cubit.checkingApprove = true;

    /// function approve
    unawaited(
      cubit.approve(),
    );
    cubit.isApprovedSubject.listen((value) async {
      final navigator = Navigator.of(context);
      if (value && !cubit.checkingApprove) {
        if (isShowLoading) {
          Navigator.pop(context);
          unawaited(cubit.gesGasLimitFirst(widget.hexString ?? ''));
        }
        await showLoadSuccess();
        navigator.pop();
      }
      if (!value && !cubit.checkingApprove) {
        if (isShowLoading) {
          navigator.pop();
          unawaited(
            cubit.gesGasLimitFirst(widget.hexString ?? ''),
          );
        }
        await showLoadFail();
        navigator.pop();
      }
    });
    isShowLoading = true;
    await showLoading();
    isShowLoading = false;
  }

  ///  Action sign (use this base call NamLV)
  ///  [gasLimitFinal] is value of gas limit final
  ///  don't use gas limit was passed into constructor
  ///   [gasPriceFinal] is value of gas price final
  ///  don't use gas price state or gas price from stream
  ///  price in cubit.gasPriceFirstSubject.value can false
  /// user can edit gas limit and gas price so
  /// DON'T USE [gasLimitFirst] AND THE FIRST GAS PRICE
  ///  USE [gasLimitFinal] AND [gasPriceFinal]
  Future<void> signTransaction(
      double gasLimitFinal, double gasPriceFinal) async {
    final String gasPriceString =
        (gasPriceFinal = gasPriceFinal / 1e9).toStringAsFixed(0);
    final String gasLimitString = gasLimitFinal.toStringAsFixed(0);
    switch (widget.typeApprove) {
      case TYPE_CONFIRM_BASE.BUY_NFT:
        {
          showLoading();
          await cubit.signTransactionWithData(
            walletAddress: PrefsService.getCurrentBEWallet(),
            contractAddress: nft_sales_address_dev2,
            nonce: nonce.toString(),
            chainId: Get.find<AppConstants>().chaninId,
            gasPrice: gasPriceString,
            gasLimit: gasLimitString,
            hexString: widget.hexString ?? '',
          );
        }
        break;
      case TYPE_CONFIRM_BASE.PLACE_BID:
        {
          showLoading();
          await cubit.signTransactionWithData(
            walletAddress: PrefsService.getCurrentBEWallet(),
            contractAddress: nft_auction_dev2,
            nonce: nonce.toString(),
            chainId: Get.find<AppConstants>().chaninId,
            gasPrice: gasPriceString,
            gasLimit: gasLimitString,
            hexString: widget.hexString ?? '',
          );
          break;
        }
      case TYPE_CONFIRM_BASE.SEND_NFT:
        {
          break;
        }
      case TYPE_CONFIRM_BASE.CANCEL_SALE:
        {
          final String wallet = PrefsService.getCurrentBEWallet();
          unawaited(showLoading());
          await cubit.signTransactionWithData(
            walletAddress: wallet,
            contractAddress: nft_sales_address_dev2,
            nonce: nonce.toString(),
            chainId: Get.find<AppConstants>().chaninId,
            gasPrice: gasPriceString,
            gasLimit: gasLimitString,
            hexString: widget.hexString ?? '',
          );
          break;
        }
      case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
        {
          cubit.showLoading();
          final nonce = await cubit.getNonce();
          await cubit.signTransactionWithData(
            walletAddress: cubit.addressWallet ?? '',
            contractAddress: cubit.getSpender(),
            nonce: nonce.toString(),
            chainId: Get.find<AppConstants>().chaninId,
            gasPrice: gasPriceString,
            gasLimit: gasLimitString,
            hexString: widget.createCollectionCubit?.transactionData ?? '',
          );
          cubit.showContent();
        }
        break;
      case TYPE_CONFIRM_BASE.PUT_ON_SALE:
        {
          unawaited(showLoading());
          final nonce = await cubit.getNonce();
          await cubit.signTransactionWithData(
            walletAddress: cubit.addressWallet ?? '',
            contractAddress: cubit.getSpender(),
            nonce: nonce.toString(),
            chainId: Get.find<AppConstants>().chaninId,
            gasPrice: gasPriceString,
            gasLimit: gasLimitString,
            hexString: widget.hexString ?? '',
          );
        }
        break;
      case TYPE_CONFIRM_BASE.SEND_TOKEN:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.SEND_OFFER:
        showLoading();
        await cubit.signTransactionWithData(
          walletAddress: cubit.addressWallet ?? '',
          contractAddress: nft_pawn_dev2,
          nonce: nonce.toString(),
          chainId: Get.find<AppConstants>().chaninId,
          gasPrice: gasPriceString,
          gasLimit: gasLimitString,
          hexString: widget.hexString ?? '',
        );
        break;
        break;
      case TYPE_CONFIRM_BASE.CANCEL_AUCTION:
        {
          final String wallet = PrefsService.getCurrentBEWallet();
          unawaited(showLoading());
          await cubit.signTransactionWithData(
            walletAddress: wallet,
            contractAddress: nft_auction_dev2,
            nonce: nonce.toString(),
            chainId: Get.find<AppConstants>().chaninId,
            gasPrice: gasPriceString,
            gasLimit: gasLimitString,
            hexString: widget.hexString ?? '',
          );
          break;
        }
      case TYPE_CONFIRM_BASE.CANCEL_PAWN:
        {
          final String wallet = PrefsService.getCurrentBEWallet();
          unawaited(showLoading());
          await cubit.signTransactionWithData(
            walletAddress: wallet,
            contractAddress: nft_pawn_dev2,
            nonce: nonce.toString(),
            chainId: Get.find<AppConstants>().chaninId,
            gasPrice: gasPriceString,
            gasLimit: gasLimitString,
            hexString: widget.hexString ?? '',
          );
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: cubit,
      listener: (context, state) {
        if (state is SignSuccess) {
          caseNavigatorSuccess(state.type, state.txh);
        }
        if (state is SignFail) {
          caseNavigatorFail(state.type, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException('', S.current.something_went_wrong),
          retry: () async {
            await cubit.getListWallets();
          },
          textEmpty: '',
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                body: GestureDetector(
                  onTap: () {
                    final FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 48),
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().bgBtsColor(),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        header(),
                        Divider(
                          thickness: 1,
                          color: AppTheme.getInstance().divideColor(),
                        ),
                        Expanded(
                          child: Container(
                            height: heightScaffold,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  widget.header ?? const SizedBox(height: 0),
                                  ...(widget.listDetail ?? []).map(
                                    (item) => Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: widget.flexTitle ?? 4,
                                              child: Text(
                                                item.title,
                                                style: textNormal(
                                                  AppTheme.getInstance()
                                                      .whiteColor()
                                                      .withOpacity(0.7),
                                                  14,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: widget.flexContent ?? 6,
                                              child: Text(
                                                item.value,
                                                style: item.isToken ?? false
                                                    ? textNormalCustom(
                                                        AppTheme.getInstance()
                                                            .fillColor(),
                                                        20,
                                                        FontWeight.w600,
                                                      )
                                                    : textNormal(
                                                        AppTheme.getInstance()
                                                            .whiteColor(),
                                                        16,
                                                      ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 16)
                                      ],
                                    ),
                                  ),
                                  if (widget.warning != null)
                                    Column(
                                      children: [
                                        const SizedBox(height: 4),
                                        widget.warning ??
                                            const SizedBox(height: 0),
                                        const SizedBox(height: 20),
                                      ],
                                    )
                                  else
                                    const SizedBox(height: 4),
                                  Divider(
                                    thickness: 1,
                                    color: AppTheme.getInstance().divideColor(),
                                  ),
                                  const SizedBox(height: 16),
                                  walletView(),
                                  const SizedBox(height: 16),
                                  StreamBuilder<bool>(
                                    stream: cubit.isApprovedStream,
                                    builder: (context, snapshot) {
                                      final data = snapshot.data ?? false;
                                      if (data ||
                                          !(widget.needApprove ?? false)) {
                                        return Column(
                                          children: [
                                            EstimateGasFee(
                                              cubit: cubit,
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const SizedBox(height: 0);
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom <=
                                            160
                                        ? heightOfBottom
                                        : 0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  key: bottomKey,
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().bgBtsColor(),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 16.w),
                          if (widget.needApprove ?? false)
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: StreamBuilder<bool>(
                                      stream: cubit.isApprovedStream,
                                      builder: (context, snapshot) {
                                        final isApproved =
                                            snapshot.data ?? false;
                                        return GestureDetector(
                                          child: ButtonGold(
                                            haveGradient: !isApproved,
                                            background: isApproved
                                                ? fillApprovedButton
                                                : null,
                                            textColor: isApproved
                                                ? borderApprovedButton
                                                : null,
                                            border: isApproved
                                                ? Border.all(
                                                    color: borderApprovedButton,
                                                    width: 2,
                                                  )
                                                : null,
                                            title: S.current.approve,
                                            isEnable: true,
                                            fixSize: false,
                                            haveMargin: false,
                                          ),
                                          onTap: () {
                                            if (!isApproved) {
                                              cubit.getGasLimitApprove(
                                                context: context,
                                                contractAddress:
                                                    widget.tokenAddress ?? '',
                                              );
                                              showPopupApprove();
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 25),
                                ],
                              ),
                            )
                          else
                            const SizedBox(
                              height: 0,
                              width: 0,
                            ),
                          Expanded(
                            child: StreamBuilder<bool>(
                              stream: cubit.isApprovedStream,
                              builder: (context, snapshot) {
                                final isApproved = snapshot.data ?? false;
                                return StreamBuilder<bool>(
                                    stream: cubit.canActionStream,
                                    builder: (context, snapshot) {
                                      final isCanAction =
                                          snapshot.data ?? false;
                                      return GestureDetector(
                                        child: ButtonGold(
                                          textColor: (isApproved ||
                                                      !(widget.needApprove ??
                                                          false)) &&
                                                  isCanAction
                                              ? null
                                              : disableText,
                                          fixSize: false,
                                          haveMargin: false,
                                          title: widget.textActiveButton,
                                          isEnable: (isApproved ||
                                                  !(widget.needApprove ??
                                                      false)) &&
                                              isCanAction,
                                        ),
                                        onTap: () {
                                          if ((isApproved ||
                                                  !(widget.needApprove ??
                                                      false)) &&
                                              isCanAction) {
                                            signTransaction(
                                              cubit.gasLimit ??
                                                  cubit.gasLimitFirst ??
                                                  0,
                                              cubit.gasPrice ?? 1e9,
                                            );
                                          }
                                        },
                                      );
                                    });
                              },
                            ),
                          ),
                          SizedBox(width: 16.w),
                        ],
                      ),
                      const SizedBox(height: 38)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> caseNavigatorFail(TYPE_CONFIRM_BASE type, String data) async {
    final navigator = Navigator.of(context);
    switch (type) {
      case TYPE_CONFIRM_BASE.BUY_NFT:
        Navigator.pop(context);
        await showLoadFail().then((_) => Navigator.pop(context)).then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BaseFail(
                    title: S.current.buy_nft,
                    content: S.current.congratulation,
                    onTapBtn: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );
        break;
      case TYPE_CONFIRM_BASE.PLACE_BID:
        Navigator.pop(context);
        await showLoadFail().then((_) => Navigator.pop(context)).then(
              (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BaseFail(
                title: S.current.place_a_bid,
                content: S.current.failed,
                onTapBtn: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
        break;
      case TYPE_CONFIRM_BASE.SEND_NFT:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.SEND_TOKEN:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.PUT_ON_SALE:
        final result = await cubit.putOnSale(txHash: data);
        navigator.pop();
        if (result) {
          await showLoadSuccess();
          navigator.popUntil((route) {
            return route.settings.name == 'put_on_market';
          });
          navigator.pop();
          // unawaited(
          //   navigator.pushReplacement(
          //     MaterialPageRoute(
          //       builder: (context) => NFTDetailScreen(
          //         typeMarket: MarketType.SALE,
          //         nftId: widget.putOnMarketModel?.nftId ?? '',
          //         typeNft: TypeNFT.SOFT_NFT,
          //       ),
          //     ),
          //   ),
          // );
        } else {
          await showLoadFail();
        }
        break;
      // TODO: Handle this case.
      case TYPE_CONFIRM_BASE.SEND_OFFER:
        Navigator.pop(context);
        await showLoadFail().then((_) => Navigator.pop(context)).then(
              (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BaseFail(
                title: S.current.send_offer,
                content: S.current.failed,
                onTapBtn: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        );
        break;
      case TYPE_CONFIRM_BASE.CANCEL_SALE:
        cubit.confirmCancelSaleWithBE(
          txnHash: data,
          marketId: nftDetailBloc.nftMarket.marketId ?? '',
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BaseSuccess(
              title: S.current.cancel_sale,
              content: S.current.congratulation,
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(
                      index: 1,
                    ),
                  ),
                );
              },
            ),
          ),
        );
        break;
      case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
        cubit.createCollection(
          type: widget.createCollectionCubit?.collectionType ?? 0,
          mapRawData:
              widget.createCollectionCubit?.getMapCreateCollection() ?? {},
          txhHash: data,
        );
        popToFirst(context);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => CollectionList(
              typeScreen: PageRouter.MY_ACC,
              addressWallet: cubit.addressWallet,
            ),
          ),
        );
        break;
      case TYPE_CONFIRM_BASE.CANCEL_AUCTION:
        cubit.confirmCancelAuctionWithBE(
          txnHash: data,
          marketId: nftDetailBloc.nftMarket.marketId ?? '',
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BaseSuccess(
              title: S.current.cancel_sale,
              content: S.current.congratulation,
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(
                      index: 1,
                    ),
                  ),
                );
              },
            ),
          ),
        );
        break;
    }
  }

  Future<void> caseNavigatorSuccess(TYPE_CONFIRM_BASE type, String data) async {
    final navigator = Navigator.of(context);
    switch (type) {
      case TYPE_CONFIRM_BASE.BUY_NFT:
        Navigator.pop(context);
        cubit.importNft(
          contract: widget.nftMarket?.collectionAddress ?? '',
          id: int.parse(widget.nftMarket?.nftTokenId ?? ''),
          address: PrefsService.getCurrentBEWallet(),
        );
        await showLoadSuccess().then((value) => Navigator.pop(context)).then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BaseSuccess(
                    title: S.current.buy_nft,
                    content: S.current.congratulation,
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(
                            index: 1,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
        cubit.buyNftRequest(
          BuyNftRequest(
            nftDetailBloc.nftMarketId,
            widget.quantity?.toInt() ?? 0,
            data,
          ),
        );
        break;
      case TYPE_CONFIRM_BASE.PLACE_BID:
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BaseSuccess(
              title: S.current.bidding,
              content: S.current.congratulation,
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(
                      index: 1,
                    ),
                  ),
                );
              },
            ),
          ),
        );
        cubit.bidNftRequest(
          BidNftRequest(
            nftDetailBloc.nftMarketId,
            widget.quantity?.toDouble() ?? 0,
            data,
          ),
        );
        break;
      case TYPE_CONFIRM_BASE.SEND_NFT:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.SEND_TOKEN:
        // TODO: Handle this case.
        break;
      case TYPE_CONFIRM_BASE.PUT_ON_SALE:
        final result = await cubit.putOnSale(txHash: data);
        navigator.pop();
        if (result) {
          await showLoadSuccess();
          navigator.popUntil((route) {
            return route.settings.name == 'put_on_market';
          });
          navigator.pop();
          // unawaited(
          //   navigator.pushReplacement(
          //     MaterialPageRoute(
          //       builder: (context) => NFTDetailScreen(
          //         typeMarket: MarketType.SALE,
          //         nftId: widget.putOnMarketModel?.nftId ?? '',
          //         typeNft: TypeNFT.SOFT_NFT,
          //       ),
          //     ),
          //   ),
          // );
        } else {
          await showLoadFail();
        }
        break;
      // TODO: Handle this case.
      case TYPE_CONFIRM_BASE.SEND_OFFER:
        await showLoadSuccess().then((value) => Navigator.pop(context)).then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BaseSuccess(
                    title: S.current.send_offer,
                    content: S.current.congratulation,
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(
                            index: 1,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
        cubit.buyNftRequest(
          BuyNftRequest(
            nftDetailBloc.nftMarketId,
            widget.quantity?.toInt() ?? 0,
            data,
          ),
        );
        break;
      case TYPE_CONFIRM_BASE.CANCEL_SALE:
        cubit.confirmCancelSaleWithBE(
          txnHash: data,
          marketId: nftDetailBloc.nftMarket.marketId ?? '',
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BaseSuccess(
              title: S.current.cancel_sale,
              content: S.current.congratulation,
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(
                      index: 1,
                    ),
                  ),
                );
              },
            ),
          ),
        );
        break;
      case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
        cubit.createCollection(
          type: widget.createCollectionCubit?.collectionType ?? 0,
          mapRawData:
              widget.createCollectionCubit?.getMapCreateCollection() ?? {},
          txhHash: data,
        );
        popToFirst(context);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => CollectionList(
              typeScreen: PageRouter.MY_ACC,
              addressWallet: cubit.addressWallet,
            ),
          ),
        );
        break;
      case TYPE_CONFIRM_BASE.CANCEL_AUCTION:
        cubit.confirmCancelAuctionWithBE(
          txnHash: data,
          marketId: nftDetailBloc.nftOnAuction.id ?? '',
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BaseSuccess(
              title: S.current.cancel_sale,
              content: S.current.congratulation,
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(
                      index: 1,
                    ),
                  ),
                );
              },
            ),
          ),
        );
        break;
    }
  }

  Container containerWithBorder({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getInstance().whiteBackgroundButtonColor(),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: child,
    );
  }

  Widget walletView() {
    return containerWithBorder(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    '${ImageAssets.image_avatar}$accountImage'
                    '.png',
                  ),
                ),
              ),
              height: 40,
              width: 40,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StreamBuilder<String>(
                      stream: cubit.nameWalletStream,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? 'Account';
                        return Text(
                          data,
                          style: textNormal(
                            AppTheme.getInstance().whiteColor(),
                            16.sp,
                          ).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    StreamBuilder<String>(
                      stream: cubit.addressWalletCoreStream,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data == null
                              ? ''
                              : snapshot.data!.formatAddressWallet(),
                          style: textNormal(
                            AppTheme.getInstance().currencyDetailTokenColor(),
                            14,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                StreamBuilder<double>(
                  stream: cubit.balanceWalletStream,
                  builder: (context, snapshot) {
                    final double data = snapshot.data ?? 0;
                    return Text(
                      '${S.current.balance}: $data',
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        16,
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      height: 40,
      // height: 28.h,
      margin: const EdgeInsets.only(
        top: 16,
        // bottom: 20.h,
        left: 16,
        right: 16,
      ),
      // EdgeInsets.only(left: 0),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_back),
          ),
          Center(
            child: Text(
              widget.title,
              style: textNormal(AppTheme.getInstance().textThemeColor(), 20.sp)
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}

extension PopUpApproveExtension on _ApproveState {
  /// show dialog loading
  Future<void> showLoading() async {
    final navigator = Navigator.of(context);
    await navigator.push(
      PageRouteBuilder(
        reverseTransitionDuration: Duration.zero,
        transitionDuration: Duration.zero,
        pageBuilder: (_, animation, ___) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.4),
            body: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
                child: const TransactionSubmit(),
              ),
            ),
          );
        },
        opaque: false,
      ),
    );
  }

  /// show dialog Error
  Future<void> showLoadFail() async {
    final navigator = Navigator.of(context);
    unawaited(
      navigator.push(
        PageRouteBuilder(
          reverseTransitionDuration: Duration.zero,
          transitionDuration: Duration.zero,
          pageBuilder: (_, animation, ___) {
            return Scaffold(
              backgroundColor: Colors.black.withOpacity(0.4),
              body: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
                  child: const TransactionSubmitFail(),
                ),
              ),
            );
          },
          opaque: false,
        ),
      ),
    );
    await Future.delayed(const Duration(seconds: secondShowPopUp), () {
      navigator.pop();
    });
  }

  /// show dialog success
  Future<void> showLoadSuccess() async {
    final navigator = Navigator.of(context);
    unawaited(
      navigator.push(
        PageRouteBuilder(
          reverseTransitionDuration: Duration.zero,
          transitionDuration: Duration.zero,
          pageBuilder: (_, animation, ___) {
            return Scaffold(
              backgroundColor: Colors.black.withOpacity(0.4),
              body: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
                  child: const TransactionSubmitSuccess(),
                ),
              ),
            );
          },
          opaque: false,
        ),
      ),
    );
    await Future.delayed(const Duration(seconds: secondShowPopUp), () {
      navigator.pop();
    });
  }

  /// show  BottomSheet approve
  void showPopupApprove() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PopUpApprove(
          approve: () {
            approve();
          },
          addressWallet: cubit.addressWallet ?? '',
          accountName: cubit.nameWallet ?? 'Account',
          imageAccount: accountImage,
          balanceWallet: cubit.balanceWallet ?? 0,
          gasFee: gasFee,
          purposeText: widget.purposeText ??
              S.current.give_this_site_permission_to_access_your_nft,
          cubit: cubit,
        ),
      ),
    );
  }
}

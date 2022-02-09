import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/bts_nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/receive_token/ui/receive_token.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_nft/send_nft.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/column_button/buil_column.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/coming_soon.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NFTDetail extends StatefulWidget {
  const NFTDetail({
    Key? key,
    required this.nftInfo,
    required this.listHistory,
    required this.walletAddress,
    required this.nameWallet,
    required this.walletCubit,
  }) : super(key: key);
  final NftInfo nftInfo;
  final List<HistoryNFT> listHistory;
  final String walletAddress;
  final String nameWallet;
  final WalletCubit walletCubit;

  @override
  _NFTDetailState createState() => _NFTDetailState();
}

class _NFTDetailState extends State<NFTDetail> {
  late final NFTBloc bloc;
  late int initLen;
  late bool initShow;

  @override
  void initState() {
    super.initState();
    bloc = NFTBloc();
    if (widget.listHistory.length > 3) {
      bloc.lenSink.add(3);
      initLen = 3;
      initShow = true;
      bloc.showSink.add(true);
    } else if (widget.listHistory.length <= 3 && widget.listHistory.isNotEmpty) {
      initLen = widget.listHistory.length;
      bloc.lenSink.add(widget.listHistory.length);
      initShow = false;
      bloc.showSink.add(false);
    } else {
      bloc.lenSink.add(0);
      initLen = 0;
      initShow = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nft = widget.nftInfo;
    return DraggableScrollableSheet(
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 9.h,
                  bottom: 23.h,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().divideColor(),
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                ),
                width: 109.w,
                height: 5.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  controller: scrollController,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                    radius: 18.r,
                                    child: Center(
                                      child: Text(
                                        nft.collectionSymbol?.substring(0, 1) ??
                                            '',
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
                                  nft.collectionName ?? '',
                                  style: textNormalCustom(
                                    Colors.white,
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                nft.name ?? '',
                                style: textNormal(
                                  AppTheme.getInstance().textThemeColor(),
                                  24,
                                ).copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '#${nft.id}',
                                    style: textNormal(
                                      AppTheme.getInstance().textThemeColor(),
                                      20,
                                    ).copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Text(
                                  nft.standard == ERC_721
                                      ? '1 ${S.current.of_all} 1'
                                      : '1 of 10',
                                  style: textNormal(
                                    AppTheme.getInstance().textThemeColor(),
                                    20,
                                  ).copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            buildRowButton(
                              ImageAssets.ic_receive,
                              ImageAssets.ic_send,
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Column(
                              children: [
                                _buildRow(
                                  title: S.current.description,
                                  detail: nft.description?.parseHtml() ?? '',
                                  type: TextType.NORMAL,
                                ),
                                _buildRow(
                                  title: S.current.nft_standard,
                                  detail: nft.standard ?? '',
                                  type: TextType.NORMAL,
                                ),
                                _buildRow(
                                  title: S.current.contract,
                                  detail: nft.contract ?? '',
                                  type: TextType.RICH_BLUE,
                                ),
                                _buildRow(
                                  title: S.current.block_chain,
                                  detail: nft.blockchain ?? '',
                                  type: TextType.NORMAL,
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<int>(
                        initialData: initLen,
                        stream: bloc.lenStream,
                        builder: (ctx, snapshot) {
                          final int len = snapshot.data ?? initLen;
                          return len == 0
                              ? Column(
                                  children: [
                                    sizedPngImage(
                                      w: 94,
                                      h: 94,
                                      image: ImageAssets.icNoTransaction,
                                    ),
                                    Text(
                                      S.current.no_transaction,
                                      style: tokenDetailAmount(
                                        color: AppTheme.getInstance()
                                            .currencyDetailTokenColor(),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: len,
                                  itemBuilder: (ctx, index) {
                                    return _buildItemHistory(index);
                                  },
                                );
                        },
                      ),
                      StreamBuilder<bool>(
                        initialData: initShow,
                        stream: bloc.showStream,
                        builder: (ctx, snapshot) {
                          final isShow = snapshot.data!;
                          return Visibility(
                            visible: isShow,
                            child: InkWell(
                              onTap: () {
                                if (widget.listHistory.length >=
                                    bloc.curLen + 10) {
                                  bloc.lenSink.add(bloc.curLen + 10);
                                } else {
                                  bloc.lenSink.add(widget.listHistory.length);
                                }
                                if (bloc.curLen == widget.listHistory.length) {
                                  bloc.showSink.add(false);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  right: 16.w,
                                  left: 16.w,
                                ),
                                height: 60.h,
                                decoration: BoxDecoration(
                                  color: AppTheme.getInstance().bgBtsColor(),
                                  border: Border(
                                    bottom: BorderSide(
                                      color:
                                          AppTheme.getInstance().divideColor(),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageAssets.ic_expanded,
                                      color: AppTheme.getInstance().fillColor(),
                                    ),
                                    SizedBox(
                                      width: 13.15.w,
                                    ),
                                    Text(
                                      S.current.view_more,
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
                      SizedBox(
                        height: 24.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ButtonGradient(
                          gradient: RadialGradient(
                            center: const Alignment(0.5, -0.5),
                            radius: 4,
                            colors:
                                AppTheme.getInstance().gradientButtonColor(),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ComingSoon(),
                              ),
                            );
                          },
                          child: Text(
                            S.current.put_on_market,
                            style: textNormal(
                              AppTheme.getInstance().textThemeColor(),
                              20,
                            ).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 38.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItemHistory(int index) {
    final historyNFT = widget.listHistory[index];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: BaseItem(
        child: InkWell(
          onTap: () {
            launch(
              Get.find<AppConstants>().bscScan +
                  ApiConstants.BSC_SCAN_TX +
                  (historyNFT.txnHash ?? ''),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getHistory(historyNFT.historyType ?? 20),
                  Text(
                    formatDateTime.format(
                      DateTime.fromMillisecondsSinceEpoch(
                        historyNFT.eventDateTime ?? 0,
                      ),
                    ),
                    style: textNormalCustom(
                      Colors.white.withOpacity(0.5),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ],
              ),
              spaceH7,
              status(
                historyNFT,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHistory(int historyType) {
    switch (historyType) {
      case 0:
        return Text(
          'Create',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 1:
        return Text(
          'Transfer',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 2:
        return Text(
          'Burn',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 3:
        return Text(
          'Put on sale',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 4:
        return Text(
          'Put on pawn',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 5:
        return Text(
          'Cancel sale',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 6:
        return Text(
          'Cancel pawn',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 7:
        return Text(
          'Cancel auction',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 8:
        return Text(
          'Buy NFT',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 9:
        return Text(
          'Sign contract',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 10:
        return Text(
          'End contract',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 11:
        return Text(
          'Auction win',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 12:
        return Text(
          'With draw',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      case 13:
        return Text(
          'Put on auction',
          style: textNormalCustom(
            Colors.white,
            14,
            FontWeight.w700,
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget status(HistoryNFT historyNFT) {
    final String walletAddress = historyNFT.walletAddress ?? '';
    final String price = '${historyNFT.price?.stringNumFormat ?? ''} '
        '${historyNFT.priceSymbol ?? ''}';
    switch (historyNFT.historyType) {
      case 0:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Created by ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              )
            ],
          ),
        );
      case 1:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Transferred from ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.fromAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
              TextSpan(
                text: ' to',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.toAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
            ],
          ),
        );
      case 2:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Burn by ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
            ],
          ),
        );
      case 3:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Put on sale by ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
              TextSpan(
                text: ' for ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: price,
                style: textNormal(
                  amountColor,
                  14,
                ),
              ),
            ],
          ),
        );
      case 4:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Put on pawn by ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
              TextSpan(
                text: ' for ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: price,
                style: textNormal(
                  amountColor,
                  14,
                ),
              ),
              TextSpan(
                text: ' expected loan',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
            ],
          ),
        );
      case 13:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Put on auction by ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
              TextSpan(
                text: ' for ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: price,
                style: textNormal(
                  amountColor,
                  14,
                ),
              ),
            ],
          ),
        );
      case 5:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Cancelled sale by  ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
            ],
          ),
        );
      case 6:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Cancelled pawn by  ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
            ],
          ),
        );
      case 7:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Cancelled auction review by ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
            ],
          ),
        );
      case 8:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Bought NFT for ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: price,
                style: textNormal(
                  amountColor,
                  14,
                ),
              ),
              TextSpan(
                text: ' by ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.toAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
            ],
          ),
        );
      case 9:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Signed between ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.fromAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
              TextSpan(
                text: ' and ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.toAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
              TextSpan(
                text: ' for ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: price,
                style: textNormal(
                  amountColor,
                  14,
                ),
              ),
              TextSpan(
                text: ' contract value',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
            ],
          ),
        );
      case 10:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Contract between ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.fromAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
              TextSpan(
                text: ' and ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.toAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
              TextSpan(
                text: ' has end. Collateral transferred to ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: historyNFT.fromAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
            ],
          ),
        );
      case 11:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: historyNFT.walletAddress!.formatAddress(index: 4),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch(
                        Get.find<AppConstants>().bscScan +
                            ApiConstants.BSC_SCAN_ADDRESS +
                            walletAddress,
                      ),
                style: richTextBlue,
              ),
              TextSpan(
                text: ' has won NFT auction for ',
                style: textNormal(
                  textHistory,
                  14,
                ),
              ),
              TextSpan(
                text: price,
                style: textNormal(
                  amountColor,
                  14,
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }

  // Widget itemTransition(int index) {
  //   final objHistory = widget.listHistory[index];
  //   return GestureDetector(
  //     onTap: () {
  //       // Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute(
  //       //     builder: (context) => TransactionDetail(
  //       //       obj: objHistory,
  //       //     ),
  //       //   ),
  //       // );
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: AppTheme.getInstance().bgBtsColor(),
  //         border: Border(
  //           top: BorderSide(
  //             color: AppTheme.getInstance().divideColor(),
  //           ),
  //         ),
  //       ),
  //       child: Container(
  //         margin: EdgeInsets.only(
  //           top: 12.h,
  //           bottom: 12.h,
  //           right: 16.w,
  //           left: 16.w,
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Text(
  //                       objHistory.name ?? '',
  //                       style: textValueNFT,
  //                     ),
  //                     SizedBox(
  //                       width: 6.w,
  //                     ),
  //                     Image.asset(
  //                       bloc.getImgStatus(objHistory.status ?? ''),
  //                     ),
  //                   ],
  //                 ),
  //                 Text(
  //                   '1 of ${objHistory.quantity}',
  //                   style: textValueNFT,
  //                 ),
  //               ],
  //             ),
  //             Text(
  //               DateTime.parse(objHistory.dateTime ?? '').stringFromDateTime,
  //               style: textValueNFT.copyWith(fontSize: 14, color: Colors.grey),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildRowButton(String first, String second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildColumnButton(
          path: first,
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Receive(
                  walletAddress: widget.walletAddress,
                  type: TokenType.NFT,
                ),
              ),
            );
          },
        ),
        SizedBox(
          width: 46.w,
        ),
        buildColumnButton(
          path: second,
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SendNft(
                  nftInfo: widget.nftInfo,
                  addressFrom: widget.walletAddress,
                  imageWallet: '',
                  nameWallet: widget.nameWallet,
                ),
              ),
            ).whenComplete(() {
              widget.walletCubit.getNFT(
                widget.walletAddress,
              );
            });
          },
        ),
      ],
    );
  }

  Row _buildRow({
    required String title,
    required String detail,
    required TextType type,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: SizedBox(
              width: 126.w,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: textFieldNFT,
                ),
              ),
            ),
          ),
          if (type == TextType.NORMAL)
            SizedBox(
              width: 225.w,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  detail,
                  style: textValueNFT,
                  maxLines: 2,
                ),
              ),
            )
          else
            GestureDetector(
              child: SizedBox(
                width: 225.w,
                child: RichText(
                  maxLines: 1,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                              Get.find<AppConstants>().bscScan +
                                  ApiConstants.BSC_SCAN_ADDRESS +
                                  detail,
                            );
                          },
                        text: detail.handleString(),
                        style: richTextBlue,
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      );
}

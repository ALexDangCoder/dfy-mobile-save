import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/bts_nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/receive_token/ui/receive_token.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_nft/send_nft.dart';
import 'package:Dfy/presentation/wallet/ui/card_nft.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/column_button/buil_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    if (widget.listHistory.length >= 3) {
      bloc.lenSink.add(3);
      initLen = 3;
      initShow = true;
      bloc.showSink.add(true);
    }
    if (widget.listHistory.length < 3) {
      initLen = widget.listHistory.length;
      bloc.lenSink.add(widget.listHistory.length);
      initShow = false;
      bloc.showSink.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nft = widget.nftInfo;
    return DraggableScrollableSheet(
      maxChildSize: 0.95,
      initialChildSize: 0.46,
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
                                  nft.standard == 'ERC-721'
                                      ? '1 of 1'
                                      //TODO
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
                                  type: TextType.NORM,
                                ),
                                _buildRow(
                                  title: S.current.nft_standard,
                                  detail: nft.standard ?? '',
                                  type: TextType.NORM,
                                ),
                                _buildRow(
                                  title: S.current.contract,
                                  detail: nft.contract ?? '',
                                  type: TextType.RICH,
                                ),
                                _buildRow(
                                  title: S.current.block_chain,
                                  detail: nft.blockchain ?? '',
                                  type: TextType.NORM,
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
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: len,
                            itemBuilder: (ctx, index) {
                              return itemTransition(index);
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
                                    top: BorderSide(
                                      color:
                                          AppTheme.getInstance().divideColor(),
                                    ),
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
                      ButtonGradient(
                        gradient: RadialGradient(
                          center: const Alignment(0.5, -0.5),
                          radius: 4,
                          colors: AppTheme.getInstance().gradientButtonColor(),
                        ),
                        onPressed: () {},
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

  Widget itemTransition(int index) {
    final objHistory = widget.listHistory[index];
    // final objDetail = bloc.listDetailHistory;
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TransactionDetail(
        //       obj: objDetail,
        //     ),
        //   ),
        // );
      },
      child: Container(
        height: 68.h,
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          border: Border(
            top: BorderSide(
              color: AppTheme.getInstance().divideColor(),
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
            top: 12.h,
            bottom: 12.h,
            right: 16.w,
            left: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        objHistory.name,
                        style: textValueNFT,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Image.asset(
                        bloc.getImgStatus(objHistory.status),
                      ),
                    ],
                  ),
                  Text(
                    '1 of ${objHistory.quantity}',
                    style: textValueNFT,
                  ),
                ],
              ),
              Text(
                objHistory.time,
                style: textValueNFT.copyWith(fontSize: 14, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

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
          if (type == TextType.NORM)
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
                            launch('$BSC_SCAN$detail');
                          },
                        text: detail.handleString(),
                        style: richTextValueNFT,
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      );
}

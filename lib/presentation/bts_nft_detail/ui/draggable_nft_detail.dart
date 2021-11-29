import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/bottom_sheet_receive_token/ui/bts_receive_dfy.dart';
import 'package:Dfy/presentation/bts_nft_detail/bloc/nft_detail_bloc.dart';
import 'package:Dfy/presentation/bts_nft_detail/ui/detail_transition.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_nft/send_nft.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/column_button/buil_column.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NFTDetail extends StatefulWidget {
  const NFTDetail({
    Key? key,
    required this.nft,
  }) : super(key: key);
  final NFT nft;

  @override
  _NFTDetailState createState() => _NFTDetailState();
}

class _NFTDetailState extends State<NFTDetail> {
  late final NFTBloc bloc;
  late int initLen;
  late bool initShow;
  final List<String> mockData = [
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
    S.current.contract_interaction,
  ];

  @override
  void initState() {
    super.initState();
    bloc = NFTBloc();
    if (mockData.length >= 3) {
      bloc.lenSink.add(3);
      initLen = 3;
      initShow = true;
      bloc.showSink.add(true);
    }
    if (mockData.length < 3) {
      initLen = mockData.length;
      bloc.lenSink.add(mockData.length);
      initShow = false;
      bloc.showSink.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nft = widget.nft;
    return DraggableScrollableSheet(
      maxChildSize: 0.95,
      initialChildSize: 0.45,
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(ImageAssets.img_card_defi),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                nft.name,
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
                                Text(
                                  nft.identity,
                                  style: textNormal(
                                    AppTheme.getInstance().textThemeColor(),
                                    20,
                                  ).copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '1 of 10',
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
                                  detail: nft.description,
                                  type: TextType.NORMAL,
                                ),
                                _buildRow(
                                  title: S.current.nft_standard,
                                  detail: nft.standard == Standard.ERC_721
                                      ? 'ERC-721'
                                      : 'ERC-1155',
                                  type: TextType.NORMAL,
                                ),
                                _buildRow(
                                  title: S.current.link,
                                  detail: nft.link,
                                  type: TextType.RICH_BLUE,
                                ),
                                _buildRow(
                                  title: S.current.contract,
                                  detail: nft.contract,
                                  type: TextType.RICH_BLUE,
                                ),
                                _buildRow(
                                  title: S.current.block_chain,
                                  detail: nft.blockChain,
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
                          final len = snapshot.data!;
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
                                if (mockData.length >= bloc.curLen + 10) {
                                  bloc.lenSink.add(bloc.curLen + 10);
                                } else {
                                  bloc.lenSink.add(mockData.length);
                                }
                                if (bloc.curLen == mockData.length) {
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
    final text = mockData[index];
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => const TransactionDetail(
            detailTransaction: '158.2578',
          ),
        );
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
                        text,
                        style: textValueNFT,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Image.asset(ImageAssets.ic_tick_circle)
                    ],
                  ),
                  Text(
                    '1 of 1',
                    style: textValueNFT,
                  ),
                ],
              ),
              Text(
                DateTime.now().toIso8601String(),
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
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => const Receive(
                walletAddress: 'aaaaaaaaaaa',
                type: TokenType.NFT,
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
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => const SendNft(),
            );
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
            SizedBox(
              width: 225.w,
              child: RichText(
                maxLines: 1,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: detail,
                      style: richTextBlue,
                    ),
                  ],
                ),
              ),
            )
        ],
      );
}

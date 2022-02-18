import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/bid_nft_request.dart';
import 'package:Dfy/data/request/buy_out_request.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/place_bid/bloc/place_bid_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/base_items/base_fail.dart';
import 'package:Dfy/widgets/base_items/base_success.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/form/custom_form.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeBid { BUY_OUT, PLACE_BID }

class PlaceBid extends StatefulWidget {
  const PlaceBid({
    Key? key,
    required this.nftOnAuction,
    required this.typeBid,
    required this.marketId,
  }) : super(key: key);
  final NFTOnAuction nftOnAuction;
  final TypeBid typeBid;
  final String marketId;

  @override
  State<PlaceBid> createState() => _PlaceBidState();
}

class _PlaceBidState extends State<PlaceBid> {
  late final PlaceBidCubit cubit;

  @override
  void initState() {
    cubit = PlaceBidCubit();
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    getBalance();
    super.initState();
  }

  Future<void> getBalance() async {
    await cubit.getBalanceToken(
      ofAddress: PrefsService.getCurrentBEWallet(),
      tokenAddress: widget.nftOnAuction.token ?? '',
    );
    if (widget.typeBid == TypeBid.BUY_OUT) {
      if (cubit.balanceValue < (widget.nftOnAuction.buyOutPrice ?? 0)) {
        cubit.warnSink.add(S.current.insufficient_balance);
        cubit.btnSink.add(false);
      } else {
        if ((widget.nftOnAuction.buyOutPrice ?? 0) == 0) {
          cubit.btnSink.add(false);
        } else {
          cubit.warnSink.add('');
          cubit.btnSink.add(true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String bidValue = widget.typeBid == TypeBid.PLACE_BID
        ? ''
        : (widget.nftOnAuction.buyOutPrice ?? 0).toString();

    Widget balanceWidget() {
      return StreamBuilder<double>(
        stream: cubit.balanceStream,
        builder: (context, snapshot) {
          return Text(
            '${S.current.your_balance} ${snapshot.data} '
            '${widget.nftOnAuction.tokenSymbol}',
            style: textNormalCustom(
              Colors.white.withOpacity(0.7),
              14,
              FontWeight.w400,
            ),
          );
        },
      );
    }

    Widget _yourBid() => Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.current.your_bid,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w600,
            ),
          ),
        );

    Widget _buildRow(String label, double price) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor().withOpacity(0.7),
              16,
              FontWeight.w400,
            ),
          ),
          Text(
            '$price ${widget.nftOnAuction.tokenSymbol}',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w700,
            ),
          ),
        ],
      );
    }

    void handleValue(
      String value,
      double bid,
      double balance,
      double priceStep,
    ) {
      if (value.isNotEmpty) {
        final yourBid = double.parse(value);
        if (balance > bid) {
          if (yourBid < bid) {
            cubit.warnSink.add(S.current.you_must_bid_greater);
            cubit.btnSink.add(false);
          } else if (yourBid > bid && yourBid < bid + priceStep) {
            cubit.warnSink.add(S.current.you_must_bid_equal);
            cubit.btnSink.add(false);
          } else {
            cubit.warnSink.add('');
            bidValue = value;
            cubit.btnSink.add(true);
          }
        } else {
          cubit.btnSink.add(false);
          cubit.warnSink.add(S.current.you_enter_balance);
        }
      } else {
        cubit.btnSink.add(false);
        cubit.warnSink.add(S.current.you_must_bid);
      }
    }

    Widget _cardCurrentBid(String url, String nameToken, double bid) {
      if (widget.typeBid == TypeBid.PLACE_BID) {
        return CustomForm(
          textValue: (value) {
            handleValue(
              value,
              bid,
              cubit.balanceValue,
              widget.nftOnAuction.priceStep ?? 0,
            );
          },
          hintText: S.current.your_bid,
          suffix: SizedBox(
            width: 50.w,
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: Image.network(url),
                  ),
                  spaceW2,
                  Text(
                    nameToken,
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor(),
                      14,
                      FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ),
          inputType: TextInputType.number,
        );
      } else {
        return Container(
          height: 64.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
              color: AppTheme.getInstance().itemBtsColors(),
              borderRadius: BorderRadius.all(Radius.circular(20.r))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  (widget.nftOnAuction.buyOutPrice ?? 0).toString(),
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    16,
                    FontWeight.w600,
                  ),
                ),
              ),
              spaceW30,
              Row(
                children: [
                  SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: Image.network(url),
                  ),
                  spaceW2,
                  Text(
                    nameToken,
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor(),
                      14,
                      FontWeight.normal,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }
    }

    Widget _spaceButton(
      BuildContext context,
      String marketId,
    ) =>
        StreamBuilder<bool>(
          initialData: false,
          stream: cubit.btnStream,
          builder: (ctx, snapshot) {
            final isEnable = snapshot.data!;
            if (isEnable) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ButtonGradient(
                  onPressed: () async {
                    if (widget.typeBid == TypeBid.PLACE_BID) {
                      await cubit
                          .getBidData(
                            contractAddress: nft_auction_dev2,
                            auctionId: widget.nftOnAuction.auctionId.toString(),
                            bidValue: bidValue,
                            context: context,
                          )
                          .then(
                            (value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Approve(
                                  title: S.current.place_a_bid,
                                  needApprove: true,
                                  payValue: bidValue,
                                  tokenAddress: widget.nftOnAuction.token,
                                  header: Column(
                                    children: [
                                      buildRowCustom(
                                        title: S.current.from,
                                        child: Text(
                                          PrefsService.getCurrentBEWallet()
                                              .formatAddressWalletConfirm(),
                                          style: textNormalCustom(
                                            AppTheme.getInstance()
                                                .textThemeColor(),
                                            16,
                                            FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      buildRowCustom(
                                        title: S.current.to,
                                        child: Text(
                                          (widget.nftOnAuction.owner ?? '')
                                              .formatAddressWalletConfirm(),
                                          style: textNormalCustom(
                                            AppTheme.getInstance()
                                                .textThemeColor(),
                                            16,
                                            FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      buildRowCustom(
                                        title: S.current.amount,
                                        child: Text(
                                          '$bidValue ${widget.nftOnAuction.tokenSymbol ?? ''}',
                                          style: textNormalCustom(
                                            AppTheme.getInstance().fillColor(),
                                            20,
                                            FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onSuccessSign: (context, data) {
                                    Navigator.pop(context);
                                    cubit.bidRequest(
                                      BidNftRequest(
                                        widget.marketId,
                                        double.parse(bidValue),
                                        data,
                                      ),
                                    );

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BaseSuccess(
                                          title: S.current.bidding,
                                          content: S.current.congratulation,
                                          callback: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  onErrorSign: (context) async {
                                    Navigator.pop(context);
                                    await showLoadFail(context)
                                        .then((_) => Navigator.pop(context))
                                        .then(
                                          (value) => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BaseFail(
                                                title: S.current.place_a_bid,
                                                onTapBtn: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                  },
                                  textActiveButton: S.current.place_a_bid,
                                  hexString: value,
                                  spender: nft_auction_dev2,
                                ),
                              ),
                            ),
                          );
                    } else {
                      await cubit
                          .getBuyOutData(
                            contractAddress: nft_auction_dev2,
                            auctionId: widget.nftOnAuction.auctionId.toString(),
                            context: context,
                          )
                          .then(
                            (value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Approve(
                                  title: S.current.place_a_bid,
                                  needApprove: true,
                                  payValue: bidValue,
                                  tokenAddress: widget.nftOnAuction.token,
                                  header: Column(
                                    children: [
                                      buildRowCustom(
                                        title: S.current.from,
                                        child: Text(
                                          PrefsService.getCurrentBEWallet()
                                              .formatAddressWalletConfirm(),
                                          style: textNormalCustom(
                                            AppTheme.getInstance()
                                                .textThemeColor(),
                                            16,
                                            FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      buildRowCustom(
                                        title: S.current.to,
                                        child: Text(
                                          (widget.nftOnAuction.owner ?? '')
                                              .formatAddressWalletConfirm(),
                                          style: textNormalCustom(
                                            AppTheme.getInstance()
                                                .textThemeColor(),
                                            16,
                                            FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      buildRowCustom(
                                        title: S.current.amount,
                                        child: Text(
                                          '$bidValue ${widget.nftOnAuction.tokenSymbol ?? ''}',
                                          style: textNormalCustom(
                                            AppTheme.getInstance().fillColor(),
                                            20,
                                            FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onSuccessSign: (context, data) {
                                    Navigator.pop(context);
                                    cubit.buyRequest(
                                      BuyOutRequest(
                                        widget.marketId,
                                        data,
                                      ),
                                    );
                                    cubit.importNft(
                                      contract: widget
                                              .nftOnAuction.collectionAddress ??
                                          '',
                                      id: int.parse(
                                          widget.nftOnAuction.nftTokenId ?? ''),
                                      address:
                                          PrefsService.getCurrentBEWallet(),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BaseSuccess(
                                          title: S.current.bidding,
                                          content: S.current.congratulation,
                                          callback: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  onErrorSign: (context) async {
                                    Navigator.pop(context);
                                    await showLoadFail(context)
                                        .then((_) => Navigator.pop(context))
                                        .then(
                                          (value) => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BaseFail(
                                                title: S.current.place_a_bid,
                                                onTapBtn: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                  },
                                  textActiveButton: S.current.buy_out,
                                  hexString: value,
                                  spender: nft_auction_dev2,
                                ),
                              ),
                            ),
                          );
                    }
                  },
                  gradient: RadialGradient(
                    center: const Alignment(0.5, -0.5),
                    radius: 4,
                    colors: AppTheme.getInstance().gradientButtonColor(),
                  ),
                  child: Text(
                    widget.typeBid == TypeBid.PLACE_BID
                        ? S.current.place_a_bid
                        : S.current.buy_out,
                    style: textNormal(
                      AppTheme.getInstance().textThemeColor(),
                      20,
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ErrorButton(
                  child: Center(
                    child: Text(
                      widget.typeBid == TypeBid.PLACE_BID
                          ? S.current.place_a_bid
                          : S.current.buy_out,
                      style: textNormal(
                        AppTheme.getInstance().textThemeColor(),
                        20,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );

    Widget warningAmount() {
      return StreamBuilder<String>(
        initialData: '',
        stream: cubit.warnStream,
        builder: (BuildContext context, snapshot) {
          return Visibility(
            visible: snapshot.data!.isNotEmpty,
            child: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  width: 343.w,
                  // height: 30.h,
                  child: Text(
                    snapshot.data ?? '',
                    style: textNormal(AppTheme.getInstance().wrongColor(), 12)
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return StateStreamLayout(
      stream: cubit.stateStream,
      error: AppException(S.current.error, S.current.something_went_wrong),
      retry: () async {},
      textEmpty: '',
      child: BaseDesignScreen(
        title: S.current.place_a_bid,
        isImage: true,
        text: ImageAssets.ic_close,
        onRightClick: () {
          Navigator.popUntil(
              context, (route) => route.settings.name == AppRouter.listNft);
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH20,
              _buildRow(
                  widget.nftOnAuction.currentPrice == 0
                      ? S.current.reserve_price
                      : S.current.current_price,
                  widget.nftOnAuction.currentPrice == 0
                      ? widget.nftOnAuction.reservePrice ?? 0
                      : widget.nftOnAuction.currentPrice ?? 0),
              spaceH8,
              _buildRow(
                  S.current.buy_out, widget.nftOnAuction.buyOutPrice ?? 0),
              spaceH8,
              _buildRow(
                  S.current.price_step, widget.nftOnAuction.priceStep ?? 0),
              spaceH16,
              _yourBid(),
              spaceH5,
              _cardCurrentBid(
                widget.nftOnAuction.urlToken ?? '',
                widget.nftOnAuction.tokenSymbol ?? '',
                widget.nftOnAuction.currentPrice == 0
                    ? (widget.nftOnAuction.reservePrice ?? 0)
                    : (widget.nftOnAuction.currentPrice ?? 0),
              ),
              spaceH8,
              ...[
                warningAmount(),
                spaceH8,
              ],
              balanceWidget(),
              spaceH344,
              _spaceButton(context, widget.marketId),
            ],
          ),
        ),
      ),
    );
  }
}

part of 'nft_detail.dart';

Widget _buildButtonPlaceBid(
  BuildContext context,
  bool start,
  bool end,
  NFTDetailBloc bloc,
  NFTOnAuction nftOnAuction,
  String marketId,
  Function handle,
) {
  if (!start && end && (nftOnAuction.isBoughtByOther == false)) {
    return ButtonGradient(
      onPressed: () {
        if (nftOnAuction.isBidProcessing == false) {
          showDialog(
            context: context,
            builder: (context) => ConnectWalletDialog(
              navigationTo: PlaceBid(
                nftOnAuction: nftOnAuction,
                typeBid: TypeBid.PLACE_BID,
                marketId: marketId,
              ),
              isRequireLoginEmail: false,
              hasFunction: true,
              function: () {
                print('Hello mother fucker');
                handle();
              },
            ),
          );
        }
      },
      gradient: RadialGradient(
        center: const Alignment(0.5, -0.5),
        radius: 4,
        colors: AppTheme.getInstance().gradientButtonColor(),
      ),
      child: (nftOnAuction.isBidProcessing == false)
          ? Text(
              S.current.place_a_bid,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                16,
                FontWeight.w700,
              ),
            )
          : processing(),
    );
  } else {
    return ErrorButton(
      child: Center(
        child: Text(
          S.current.place_a_bid,
          style: textNormalCustom(
            Colors.white,
            20,
            FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

Widget waitingAcceptAuction() {
  return Text(
    S.current.waiting_accept_auction,
    style: textNormalCustom(
      Colors.red,
      14,
      FontWeight.w400,
    ),
    textAlign: TextAlign.start,
    maxLines: 2,
  );
}

Widget _buildButtonBuyOut(
  BuildContext context,
  NFTOnAuction nftOnAuction,
  String marketId,
  bool start,
  bool end,
  Function reload,
) {
  return ButtonTransparent(
    isEnable: !start == true && end == true,
    child: nftOnAuction.marketStatus == 10
        ? processing()
        : Text(
            (nftOnAuction.marketStatus == 15)
                ? S.current.put_on_market_success
                : S.current.buy_out,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w700,
            ),
          ),
    onPressed: () {
      if (nftOnAuction.marketStatus != 10 && nftOnAuction.marketStatus != 15) {
        showDialog(
          context: context,
          builder: (ctx) => ConnectWalletDialog(
            navigationTo: PlaceBid(
              nftOnAuction: nftOnAuction,
              typeBid: TypeBid.BUY_OUT,
              marketId: marketId,
            ),
            isRequireLoginEmail: false,
            hasFunction: true,
            function: () {
              print('fuck auction');
              nftOnAuction.isBoughtByOther = true;
              nftOnAuction.marketStatus = 10;
              bloc.emit(NftOnAuctionSuccess(nftOnAuction));
              Timer(const Duration(seconds: 20), () {
                bloc.emit(NFTDetailInitial());
                nftOnAuction.isBoughtByOther = true;
                nftOnAuction.marketStatus = 15;
                bloc.emit(NftOnAuctionSuccess(nftOnAuction));
                showDialogSuccess(
                  context,
                  alert: S.current.buy_out_success,
                  text: S.current.buy_out_success_scrip,
                );
              });
            },
          ),
        );
      }
    },
  );
}

Widget buttonCancelAuction({
  required bool approveAdmin,
  required NFTDetailBloc bloc,
  required BuildContext context,
  required NFTOnAuction nftMarket,
  required Function refresh,
}) {
  if (!approveAdmin) {
    return ButtonGradient(
      onPressed: () async {
        if (nftMarket.marketStatus == 8) {
          return;
        }
        if (nftMarket.marketStatus == 0) {
          Navigator.pop(context);
          return;
        }
        final nav = Navigator.of(context);
        final String dataString = await bloc.getDataStringForCancelAuction(
          context: context,
          auctionId: nftMarket.auctionId.toString(),
        );
        final List<DetailItemApproveModel> listApprove = [];
        if (nftMarket.nftStandard == ERC_721) {
          listApprove.add(
            DetailItemApproveModel(
              title: NFT,
              value: nftMarket.name ?? '',
            ),
          );
          listApprove.add(
            DetailItemApproveModel(
              title: S.current.quantity,
              value: '${nftMarket.numberOfCopies}',
            ),
          );
        } else {
          listApprove.add(
            DetailItemApproveModel(
              title: NFT,
              value: nftMarket.name ?? '',
            ),
          );
        }
        final bool isSuccess = await nav.push(
          MaterialPageRoute(
            builder: (context) => approveWidget(
              nftOnAuction: nftMarket,
              dataString: dataString,
              dataInfo: listApprove,
              spender: Get.find<AppConstants>().nftAuction,
              cancelInfo: S.current.auction_cancel_info,
              cancelWarning: S.current.cancel_auction_warning,
              title: S.current.cancel_aution,
              onFail: (context) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaseFail(
                      title: S.current.cancel_aution,
                      content: S.current.failed,
                      onTapBtn: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              onSuccess: (context, data) async {
                final navigator = Navigator.of(context);
                await bloc.confirmCancelAuctionWithBE(
                  txnHash: data,
                  marketId: nftMarket.id ?? '',
                );
                await navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BaseSuccess(
                      title: S.current.cancel_aution,
                      content: S.current.congratulation,
                      callback: () {
                        navigator.pop();
                      },
                    ),
                  ),
                );
                navigator.pop(true);
              },
            ),
          ),
        );
        if (isSuccess) {
          refresh();
          Timer(const Duration(seconds: 30), () {
            nftMarket.marketStatus = 0;
            bloc.emit(NftOnAuctionSuccess(nftMarket));
            showDialogSuccess(context);
          });
        }
      },
      gradient: RadialGradient(
        center: const Alignment(0.5, -0.5),
        radius: 4,
        colors: AppTheme.getInstance().gradientButtonColor(),
      ),
      child: nftMarket.marketStatus == 8
          ? processing()
          : Text(
              nftMarket.marketStatus == 0
                  ? S.current.cancel_success
                  : S.current.cancel_aution,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                16,
                FontWeight.w700,
              ),
            ),
    );
  } else {
    return const SizedBox();
  }
}

Container _priceContainerOnAuction({
  required NFTOnAuction nftOnAuction,
  required bool isEnd,
}) {
  final bool isBidding = nftOnAuction.numberBid != 0;
  return Container(
    width: 343.w,
    height: 64.h,
    margin: EdgeInsets.only(top: 12.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          !isBidding
              ? S.current.reserve_price
              : (isEnd ? S.current.auction_win : S.current.is_bid),
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
                SizedBox(
                  height: 20.w,
                  width: 20.w,
                  child: Image.network(
                    nftOnAuction.urlToken ?? '',
                    errorBuilder: (context, url, error) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
                spaceW4,
                Text(
                  '${!isBidding ? formatPrice.format(nftOnAuction.reservePrice) : formatPrice.format(nftOnAuction.currentPrice)} '
                  '${nftOnAuction.tokenSymbol ?? ''}',
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
                '~ ${formatUSD.format(
                  !isBidding
                      ? ((nftOnAuction.reservePrice ?? 0) *
                          (nftOnAuction.usdExchange ?? 0))
                      : ((nftOnAuction.currentPrice ?? 0) *
                          (nftOnAuction.usdExchange ?? 0)),
                )}',
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

SizedBox _timeContainer(
  bool start,
  int startTime,
  bool end,
  int endTime,
  Function onRefresh,
) =>
    SizedBox(
      width: 343.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (start)
            Text(
              S.current.auction_start_in,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                14,
                FontWeight.normal,
              ),
            )
          else
            Text(
              end ? S.current.auction_end_in : S.current.auction_ends,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                14,
                FontWeight.normal,
              ),
            ),
          spaceH16,
          if (start)
            CountDownView(
              timeInMilliSecond: startTime,
              onRefresh: onRefresh,
              timeEnd: endTime,
            )
          else
            CountDownView(
              timeInMilliSecond: endTime,
              onRefresh: onRefresh,
              timeEnd: endTime,
            ),
          spaceH24,
        ],
      ),
    );

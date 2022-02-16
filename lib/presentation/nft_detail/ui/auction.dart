part of 'nft_detail.dart';

Widget _buildButtonPlaceBid(
  BuildContext context,
  bool start,
  bool end,
  NFTDetailBloc bloc,
  NFTOnAuction nftOnAuction,
  String marketId,
) {
  if (!start && end) {
    return ButtonGradient(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ConnectWalletDialog(
            navigationTo: PlaceBid(
              nftOnAuction: nftOnAuction,
              typeBid: TypeBid.PLACE_BID,
              marketId: marketId,
            ),
            isRequireLoginEmail: false,
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
) {
  return ButtonTransparent(
    isEnable: !start == true && end == true,
    child: Text(
      S.current.buy_out,
      style: textNormalCustom(
        AppTheme.getInstance().textThemeColor(),
        16,
        FontWeight.w700,
      ),
    ),
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) => ConnectWalletDialog(
          navigationTo: PlaceBid(
            nftOnAuction: nftOnAuction,
            typeBid: TypeBid.BUY_OUT,
            marketId: marketId,
          ),
          isRequireLoginEmail: false,
        ),
      );
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
              spender: nft_auction_dev2,
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
          await refresh();
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
              S.current.cancel_aution,
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
                  '${!isBidding ? nftOnAuction.reservePrice : nftOnAuction.currentPrice} '
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
                  isBidding
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

SizedBox _timeContainer(bool start, int startTime, bool end, int endTime) =>
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
            CountDownView(timeInMilliSecond: startTime)
          else
            CountDownView(timeInMilliSecond: endTime),
          spaceH24,
        ],
      ),
    );

part of 'nft_detail.dart';

Widget _buildButtonPlaceBid(
  BuildContext context,
  bool start,
  bool end,
  NFTDetailBloc bloc,
  NFTOnAuction nftOnAuction,
) {
  if (!start && end) {
    return ButtonGradient(
      onPressed: () async {
        await bloc
            .getBalanceToken(
              ofAddress: bloc.wallets.first.address ?? '',
              tokenAddress: bloc.nftOnAuction.token ?? '',
            )
            .then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaceBid(
                    nftOnAuction: nftOnAuction,
                    balance: value,
                  ),
                ),
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

Widget buttonCancelAuction({
  required bool approveAdmin,
  required NFTDetailBloc bloc,
  required BuildContext context,
  NFTOnAuction nftMarket,
}) {
  if (!approveAdmin) {
    return ButtonGradient(
      onPressed: () async {
        final nav = Navigator.of(context);
        final String dataString = await bloc.getDataStringForCancelAuction(
          context: context,
        );
        unawaited(
          nav.push(
            MaterialPageRoute(
              builder: (context) => approveWidget(
                dataString: dataString,
                dataInfo: bloc.initListApprove(
                  type: TYPE_CONFIRM_BASE.CANCEL_AUCTION,
                ),
                type: TYPE_CONFIRM_BASE.CANCEL_AUCTION,
                cancelInfo: S.current.auction_cancel_info,
                cancelWarning: S.current.cancel_auction_warning,
                title: S.current.cancel_aution,
              ),
            ),
          ),
        );
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
                if (nftOnAuction.urlToken?.isNotEmpty ?? true)
                  Image(
                    image: NetworkImage(
                      nftOnAuction.urlToken ?? '',
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
                formatUSD.format(
                  isBidding
                      ? ((nftOnAuction.reservePrice ?? 0) *
                          (nftOnAuction.usdExchange ?? 0))
                      : ((nftOnAuction.currentPrice ?? 0) *
                          (nftOnAuction.usdExchange ?? 0)),
                ),
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

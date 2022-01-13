part of 'nft_detail.dart';

Widget _buildButtonPlaceBid(
    BuildContext context, bool start, bool end, NFTDetailBloc bloc) {
  if (!start && end) {
    return ButtonGradient(
      onPressed: () async {

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

Container _priceContainerOnAuction({
  required NFTOnAuction nftOnAuction,
}) {
  final bool isBidding = nftOnAuction.isBidByOther ?? false;
  return Container(
    width: 343.w,
    height: 64.h,
    margin: EdgeInsets.only(top: 12.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isBidding ? S.current.reserve_price : S.current.is_bid,
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
                  '${isBidding ? nftOnAuction.reservePrice : nftOnAuction.currentPrice} '
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

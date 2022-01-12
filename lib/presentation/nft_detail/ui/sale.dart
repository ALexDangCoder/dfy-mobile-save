part of 'nft_detail.dart';

Container _priceContainerOnSale({
  required double price,
  String shortName = 'DFY',
  String urlToken = '',
  double usdExchange = 0,
}) =>
    Container(
      width: 343.w,
      height: 64.h,
      margin: EdgeInsets.only(top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.price,
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
                  if (urlToken.isNotEmpty)
                    Image(
                      image: NetworkImage(
                        urlToken,
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
                    '$price $shortName',
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
                  formatUSD.format(price * usdExchange),
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

Widget _buildButtonBuyOutOnSale(BuildContext context, NFTDetailBloc bloc) {
  return ButtonGradient(
    onPressed: () async {
      await bloc
          .getBalanceToken(
        ofAddress: bloc.wallets.first.address ?? '',
        tokenAddress: bloc.nftMarket.token ?? '',
      )
          .then(
            (value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuyNFT(
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
      S.current.buy_nft,
      style: textNormalCustom(
        AppTheme.getInstance().textThemeColor(),
        16,
        FontWeight.w700,
      ),
    ),
  );
}



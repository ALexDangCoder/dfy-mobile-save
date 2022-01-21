part of 'nft_detail.dart';

Container _priceNotOnMarket() => Container(
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
              Text(
                '0',
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  20,
                  FontWeight.w600,
                ),
              ),
              Text(
                '0',
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                  14,
                  FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );

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

Widget _buildButtonBuyOutOnSale(
  BuildContext context,
  NFTDetailBloc bloc,
  NftMarket nftMarket,
  bool isBought,
) {
  return ButtonGradient(
    onPressed: () async {
      if (isBought) {
        _showDialog(context, nftMarket);
      } else {
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
                    nftMarket: nftMarket,
                    balance: value,
                    walletAddress: bloc.wallets.first.address ?? '',
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
      S.current.buy_nft,
      style: textNormalCustom(
        AppTheme.getInstance().textThemeColor(),
        16,
        FontWeight.w700,
      ),
    ),
  );
}

Widget _buildButtonCancelOnSale(
  BuildContext context,
  NFTDetailBloc bloc,
  NftMarket nftMarket,
) {
  return ButtonGradient(
    onPressed: () async {
      /// TODO: handle cancel sale buy nftMarket.isOwner == true
      final nav = Navigator.of(context);
      final double gas = await bloc.getGasLimitForCancel(context: context);
      if (gas > 0) {
        unawaited(
          nav.push(
            MaterialPageRoute(
              builder: (context) => approveWidget(),
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
    child: nftMarket.marketStatus == 7
        ? processing()
        : Text(
            S.current.cancel_sale,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w700,
            ),
          ),
  );
}

Widget processing() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 24.w,
        height: 24.h,
        child: CircularProgressIndicator(
          strokeWidth: 4.r,
          color: AppTheme.getInstance().whiteColor(),
        ),
      ),
      spaceW10,
      Text(
        'Processing',
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          16,
          FontWeight.w700,
        ),
      ),
    ],
  );
}

void _showDialog(BuildContext context, NftMarket nftMarket) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      // return object of type Dialog
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              36.0.r,
            ),
          ),
        ),
        backgroundColor: AppTheme.getInstance().selectDialogColor(),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage(ImageAssets.img_warning),
                  width: 24.h,
                  height: 28.h,
                ),
                spaceW12,
                Text(
                  S.current.warning,
                  style: textNormalCustom(
                    Colors.white,
                    20,
                    FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              S.current.purchase_being_processed,
              style: textNormalCustom(
                Colors.white,
                12,
                FontWeight.w400,
              ),
            ),
            Text(
              S.current.error_might_occur,
              style: textNormalCustom(
                Colors.white,
                12,
                FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Divider(
            height: 1.h,
            color: AppTheme.getInstance().divideColor(),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Center(
                    child: Text(
                      S.current.cancel,
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        20,
                        FontWeight.w700,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: AppTheme.getInstance().divideColor(),
              ),
              Expanded(
                child: InkWell(
                  child: Center(
                    child: Text(
                      S.current.continue_s,
                      style: textNormalCustom(
                        fillYellowColor,
                        20,
                        FontWeight.w700,
                      ),
                    ),
                  ),
                  onTap: () async {
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
                                nftMarket: nftMarket,
                                balance: value,
                                walletAddress: bloc.wallets.first.address ?? '',
                              ),
                            ),
                          ),
                        );
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Widget _buildButtonPutOnMarket(
  BuildContext context,
  NFTDetailBloc bloc,
  NftMarket nftMarket,
) {
  return ButtonGradient(
    onPressed: () async {},
    gradient: RadialGradient(
      center: const Alignment(0.5, -0.5),
      radius: 4,
      colors: AppTheme.getInstance().gradientButtonColor(),
    ),
    child: nftMarket.processStatus == 5
        ? processing()
        : Text(
            S.current.put_on_market,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w700,
            ),
          ),
  );
}

Approve approveWidget() {
  return Approve(
    listDetail: bloc.initListApprove(),
    title: S.current.cancel_sale,
    header: Container(
      padding: EdgeInsets.only(
        top: 16.h,
        bottom: 20.h,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        S.current.cancel_sale_info,
        style: textNormal(
          AppTheme.getInstance().whiteColor(),
          16,
        ).copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    warning: Row(
      children: [
        sizedSvgImage(
            w: 16.67.w, h: 16.67.h, image: ImageAssets.ic_warning_canel),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: Text(
            S.current.customer_cannot,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textNormal(
              AppTheme.getInstance().currencyDetailTokenColor(),
              14,
            ),
          ),
        ),
      ],
    ),
    textActiveButton: S.current.cancel_sale,
    typeApprove: TYPE_CONFIRM_BASE.CANCEL_SALE,
    hexString: '', //todo
  );
}

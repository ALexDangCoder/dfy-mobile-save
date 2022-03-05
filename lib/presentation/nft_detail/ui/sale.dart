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
  String shortName = DFY,
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
                  SizedBox(
                    height: 20.w,
                    width: 20.w,
                    child: Image.network(
                      urlToken,
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
                    '${formatPrice.format(price)} $shortName',
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
                  '~ ${formatUSD.format(price * usdExchange)}',
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

Widget _buildButtonBuy(
  BuildContext context,
  NFTDetailBloc bloc,
  NftMarket nftMarket,
  bool isBought,
  String marketId,
) {
  return ButtonGradient(
    onPressed: () {
      if (isBought) {
        _showDialog(
          context,
          nftMarket,
          marketId,
        );
      } else {
        showDialog(
          builder: (context) => ConnectWalletDialog(
            navigationTo: BuyNFT(
              nftMarket: nftMarket,
              marketId: marketId,
            ),
            isRequireLoginEmail: false,
          ),
          context: context,
        ).then((value) => null);
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
  Function() reload,
) {
  return ButtonGradient(
    onPressed: () async {
      if (nftMarket.marketStatus == 7) {
        return;
      }
      if (nftMarket.marketStatus == 0) {
        Navigator.pop(context);
        return;
      }
      final nav = Navigator.of(context);
      final String dataString = await bloc.getDataStringForCancel(
        context: context,
        orderId: nftMarket.orderId.toString(),
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
      await showDialog(
        context: context,
        builder: (BuildContext context) => const ConnectWalletDialog(
          isRequireLoginEmail: false,
        ),
      );
      final walletCore = PrefsService.getCurrentWalletCore();
      final walletBE = PrefsService.getCurrentBEWallet();
      if (walletBE == walletCore) {
        final bool isSuccess = await nav.push(
          MaterialPageRoute(
            builder: (context) => approveWidget(
              nftMarket: nftMarket,
              dataString: dataString,
              dataInfo: listApprove,
              spender: Get.find<AppConstants>().nftSalesAddress,
              cancelInfo: S.current.cancel_sale_info,
              cancelWarning: S.current.customer_cannot,
              title: S.current.cancel_sale,
              onFail: (context) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaseFail(
                      title: S.current.cancel_sale,
                      content: S.current.failed,
                      onTapBtn: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                );
              },
              onSuccess: (context, data) async {
                final navigator = Navigator.of(context);
                await bloc.confirmCancelSaleWithBE(
                  txnHash: data,
                  marketId: nftMarket.marketId ?? '',
                );
                await navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BaseSuccess(
                      title: S.current.cancel_sale,
                      content: S.current.congratulation,
                      callback: () {
                        navigator.pop(true);
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
          reload();
          Timer(const Duration(seconds: 15), () {
            nftMarket.marketStatus = 0;
            bloc.emit(NftOnSaleSuccess(nftMarket));
          });
        }
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
            nftMarket.marketStatus == 0
                ? S.current.cancel_success
                : S.current.cancel_sale,
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

void _showDialog(BuildContext context, NftMarket nftMarket, String marketId) {
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
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConnectWalletDialog(
                        navigationTo: BuyNFT(
                          nftMarket: nftMarket,
                          marketId: marketId,
                        ),
                        isRequireLoginEmail: false,
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

void showAlert(
  BuildContext context,
  String walletAddress,
) {
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
              S.current.warning_connect_address,
              style: textNormalCustom(
                Colors.white,
                12,
                FontWeight.w400,
              ),
            ),
            Text(
              S.current.warning_connect_address_2 +
                  walletAddress.formatAddressWallet() +
                  S.current.to_perform_this_action,
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
          SizedBox(
            height: 50.h,
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  S.current.ok,
                  style: textNormalCustom(
                    fillYellowColor,
                    20,
                    FontWeight.w700,
                  ),
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}

Widget _buildButtonPutOnMarket(
  BuildContext context,
  NFTDetailBloc bloc,
  NftMarket nftMarket,
  String? nftId,
  Function reload,
) {
  return ButtonGradient(
    onPressed: () async {
      if (nftMarket.isOwner ?? false) {
        if (nftMarket.processStatus == 9) {
          Navigator.pop(context);
          return;
        }
        if (nftMarket.processStatus != 5 &&
            nftMarket.processStatus != 6 &&
            nftMarket.processStatus != 3 &&
            nftMarket.marketStatus != 6 &&
            nftMarket.marketStatus != 5) {
          final navigator = Navigator.of(context);
          List<dynamic>? splitImageLink = nftMarket.image?.split('/');
          String imageId = '';
          if ((splitImageLink ?? []).isNotEmpty) {
            imageId = (splitImageLink ?? []).last.toString();
          }
          final result = await navigator.push(
            MaterialPageRoute(
              builder: (context) => PutOnMarketScreen(
                putOnMarketModel: PutOnMarketModel.putOnSale(
                  nftTokenId: int.parse(nftMarket.nftTokenId ?? '0'),
                  nftId: nftId ?? '',
                  nftType: nftMarket.typeNFT == TypeNFT.HARD_NFT ? 1 : 0,
                  collectionAddress: nftMarket.collectionAddress ?? '',
                  nftMediaType: nftMarket.typeImage == TypeImage.IMAGE
                      ? 'image'
                      : 'video',
                  totalOfCopies: nftMarket.totalCopies ?? 1,
                  nftName: nftMarket.name ?? '',
                  nftMediaCid: imageId,
                  // lấy id
                  collectionName: nftMarket.collectionName ?? '',
                  collectionIsWhitelist: nftMarket.isWhitelist ?? false,
                  nftStandard: int.parse(nftMarket.nftStandard ?? '0'),
                ),
              ),
              settings: const RouteSettings(
                name: AppRouter.putOnSale,
              ),
            ),
          );
          if (result != null) {
            reload();
            Timer(const Duration(seconds: 15), () {
              nftMarket.processStatus = 9;
              bloc.emit(NftNotOnMarketSuccess(nftMarket));
            });
          }
        }
      } else {
        showAlert(context, nftMarket.owner ?? '');
      }
    },
    gradient: RadialGradient(
      center: const Alignment(0.5, -0.5),
      radius: 4,
      colors: AppTheme.getInstance().gradientButtonColor(),
    ),
    child: (nftMarket.processStatus == 5 ||
            nftMarket.processStatus == 6 ||
            nftMarket.processStatus == 3 ||
            nftMarket.marketStatus == 5 ||
            nftMarket.marketStatus == 6)
        ? processing()
        : Text(
            nftMarket.processStatus == 9
                ? S.current.put_on_market_success
                : S.current.put_on_market,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w700,
            ),
          ),
  );
}

Approve approveWidget({
  required String dataString,
  required String title,
  required String cancelInfo,
  required String cancelWarning,
  required String spender,
  required List<DetailItemApproveModel> dataInfo,
  NFTOnAuction? nftOnAuction,
  NftOnPawn? nftOnPawn,
  NftMarket? nftMarket,
  required Function(BuildContext) onFail,
  required Function(BuildContext, String) onSuccess,
}) {
  return Approve(
    listDetail: dataInfo,
    title: title,
    header: Container(
      padding: EdgeInsets.only(
        top: 16.h,
        bottom: 20.h,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        cancelInfo,
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
          w: 16.67.w,
          h: 16.67.h,
          image: ImageAssets.ic_warning_canel,
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: Text(
            cancelWarning,
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
    textActiveButton: title,
    spender: spender,
    hexString: dataString,
    onErrorSign: onFail,
    onSuccessSign: onSuccess,
  );
}

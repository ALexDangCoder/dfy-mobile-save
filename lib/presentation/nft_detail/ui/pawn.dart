part of 'nft_detail.dart';

Container _priceContainerOnPawn({required NftOnPawn nftOnPawn}) {
  return Container(
    width: 343.w,
    height: 50.h,
    margin: EdgeInsets.only(top: 12.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.expected_loan,
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
                if (nftOnPawn.urlToken != null)
                  ClipRRect(
                    child: Image(
                      image: NetworkImage(
                        nftOnPawn.urlToken ?? '',
                      ),
                      width: 20.w,
                      height: 20.h,
                    ),
                  )
                else
                  Image(
                    image: const AssetImage(ImageAssets.symbol),
                    width: 20.w,
                    height: 20.h,
                  ),
                spaceW4,
                Text(
                  '${formatPrice.format(nftOnPawn.expectedLoanAmount)} '
                  '${nftOnPawn.expectedCollateralSymbol}',
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
                  (nftOnPawn.expectedLoanAmount ?? 0) *
                      (nftOnPawn.usdExchange ?? 0),
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

Widget _durationRowOnPawn({
  required int durationType,
  required int durationQty,
}) {
  final String duration =
      (durationType == 0) ? S.current.week : S.current.month;
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.current.duration,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor().withOpacity(0.7),
              14,
              FontWeight.normal,
            ),
          ),
          Text(
            '$durationQty $duration',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w600,
            ),
          ),
        ],
      ),
      spaceH12,
    ],
  );
}

Widget _buildButtonSendOffer(BuildContext context, NftOnPawn nftOnPawn) {
  return ButtonGradient(
    onPressed: () {
      showDialog(
        builder: (context) => ConnectWalletDialog(
          navigationTo: SendOffer(
            nftOnPawn: nftOnPawn,
          ),
          isRequireLoginEmail: true,
        ),
        context: context,
      );
    },
    gradient: RadialGradient(
      center: const Alignment(0.5, -0.5),
      radius: 4,
      colors: AppTheme.getInstance().gradientButtonColor(),
    ),
    child: Text(
      S.current.send_offer,
      style: textNormalCustom(
        AppTheme.getInstance().textThemeColor(),
        16,
        FontWeight.w700,
      ),
    ),
  );
}

Widget _buildButtonCancelOnPawn(
  BuildContext context,
  NFTDetailBloc bloc,
  NftOnPawn nftMarket,
  Function refresh,
) {
  return ButtonGradient(
    onPressed: () async {
      if (nftMarket.status == 7 || nftMarket.status == 5) {
        return;
      }
      if (nftMarket.status == 0) {
        Navigator.pop(context, true);
        return;
      }
      final nav = Navigator.of(context);
      final String dataString = await bloc.getDataStringForCancelPawn(
        pawnId: (nftMarket.bcCollateralId ?? 0).toString(),
      );
      final List<DetailItemApproveModel> listApprove = [];
      if (nftMarket.nftCollateralDetailDTO?.nftStandard == 0) {
        listApprove.add(
          DetailItemApproveModel(
            title: NFT,
            value: nftMarket.nftCollateralDetailDTO?.nftName ?? '',
          ),
        );
        listApprove.add(
          DetailItemApproveModel(
            title: S.current.quantity,
            value: '${nftMarket.nftCollateralDetailDTO?.numberOfCopies}',
          ),
        );
      } else {
        listApprove.add(
          DetailItemApproveModel(
            title: NFT,
            value: nftMarket.nftCollateralDetailDTO?.nftName ?? '',
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
              nftOnPawn: nftMarket,
              dataString: dataString,
              dataInfo: listApprove,
              spender: Get.find<AppConstants>().nftPawn,
              cancelInfo: S.current.pawn_cancel_info,
              cancelWarning: S.current.pawn_cancel_warning,
              title: S.current.cancel_pawn,
              onFail: (context) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BaseFail(
                      title: S.current.cancel_pawn,
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
                await bloc.confirmCancelPawnWithBE(
                  id: nftMarket.id ?? 0,
                );
                await navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BaseSuccess(
                      title: S.current.cancel_pawn,
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
          refresh();
          Timer(const Duration(seconds: 30), () {
            nftMarket.status = 0;
            bloc.emit(NftOnPawnSuccess(nftMarket));
            showDialogSuccess(context);
          });
        }
      }
    },
    gradient: RadialGradient(
      center: const Alignment(0.5, -0.5),
      radius: 4,
      colors: AppTheme.getInstance().gradientButtonColor(),
    ),
    child: nftMarket.status == 7 || nftMarket.status == 5
        ? processing()
        : Text(
            nftMarket.status == 0
                ? S.current.cancel_success_s
                : S.current.cancel_pawn,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w700,
            ),
          ),
  );
}

void showDialogSuccess(BuildContext context,
    {String? alert, String? text, bool? onlyPop, bool? hasImage}) {
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
        title: SizedBox(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: hasImage == true ? 70.h : 0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        alert ?? S.current.cancel_success_s,
                        style: textNormalCustom(
                          Colors.white,
                          20,
                          FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Center(
                      child: Text(
                        text ?? S.current.back_and_refresh_data,
                        style: textNormalCustom(
                          Colors.white,
                          12,
                          FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasImage ?? false)
                Align(
                  alignment: Alignment.topCenter,
                  child: sizedSvgImage(
                    w: 135,
                    h: 70,
                    image: ImageAssets.img_sign_loan_sc,
                  ),
                ),
            ],
          ),
        ),
        actions: <Widget>[
          Divider(
            height: 1.h,
            color: AppTheme.getInstance().divideColor(),
          ),
          Center(
            child: TextButton(
              child: Text(
                S.current.ok,
                style: textNormalCustom(
                  AppTheme.getInstance().fillColor(),
                  20,
                  FontWeight.w700,
                ),
              ),
              onPressed: () {
                if (onlyPop ?? false) {
                  Navigator.of(ctx).pop();
                } else {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop(true);
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      );
    },
  );
}

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
                  '${nftOnPawn.expectedLoanAmount} '
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
                formatUSD.format(
                  (nftOnPawn.expectedLoanAmount ?? 0) *
                      (nftOnPawn.usdExchange ?? 0),
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

Widget _durationRowOnPawn({
  required int durationType,
  required int durationQty,
}) {
  final String duration = (durationType == 0) ? 'week' : 'months';
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
  /// TODO: if un login => login => send offer
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
      final bool isSuccess = await nav.push(
        MaterialPageRoute(
          builder: (context) => approveWidget(
            nftOnPawn: nftMarket,
            dataString: dataString,
            dataInfo: listApprove,
            type: TYPE_CONFIRM_BASE.CANCEL_PAWN,
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
    child: nftMarket.status == 7
        ? processing()
        : Text(
            S.current.cancel_pawn,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w700,
            ),
          ),
  );
}

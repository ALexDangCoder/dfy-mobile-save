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
                if (nftOnPawn.urlToken?.isNotEmpty ?? false)
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
            '${S.current.duration}:',
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

Widget _buttonAction(
    {required BuildContext context,
    required NFTDetailBloc bloc,
    required NftOnPawn nftOnPawn}) {
  final profileJson = PrefsService.getUserProfile();
  final UserProfileModel userProfile = userProfileFromJson(profileJson);
  final userId = userProfile.id ?? -1;
  if (userId == nftOnPawn.userId) {
    return _buildButtonCancelOnPawn(
      context,
      bloc,
      nftOnPawn,
    );
  } else {
    return _buildButtonSendOffer(context);
  }
}

Widget _buildButtonSendOffer(BuildContext context) {
  return ButtonGradient(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return const SendOffer();
          },
        ),
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
  NftOnPawn nftOnPawn,
) {
  return ButtonGradient(
    onPressed: () async {
      final nav = Navigator.of(context);
      final String dataString = await bloc.getDataStringForCancelPawn(
        pawnId: nftOnPawn.nftCollateralDetailDTO?.nftId ?? '',
      );
      unawaited(
        nav.push(
          MaterialPageRoute(
            builder: (context) => approveWidget(
              dataString: dataString,
              dataInfo: bloc.initListApprove(
                type: TYPE_CONFIRM_BASE.CANCEL_PAWN,
              ),
              type: TYPE_CONFIRM_BASE.CANCEL_PAWN,
              cancelInfo: S.current.pawn_cancel_info,
              cancelWarning: S.current.pawn_cancel_warning,
              title: S.current.cancel_pawn,
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
    child: nftOnPawn.status == 7
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

part of 'nft_detail.dart';

NFTDetailBloc bloc = nftKey.currentState?.bloc ?? NFTDetailBloc();

Widget _leading(BuildContext context) => InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: roundButton(image: ImageAssets.ic_btn_back_svg),
      ),
    );

Widget action(
  BuildContext context,
  String collectionAddress,
  bool isOwner,
  String nftTokenId,
  String walletAddress,
  String nftId,
  NFTDetailBloc bloc,
    NftMarket nftMarket,
  Function reload,
) {
  final NftInfo nftInfo = NftInfo(
    contract: collectionAddress.toLowerCase(),
    id: nftTokenId,
    nftId: nftMarket.id,
    collectionSymbol: 'DFY-NFT',
    collectionId: nftMarket.collectionID?.toLowerCase(),
    collectionName: nftMarket.collectionName,
  );
  return InkWell(
    onTap: () {
      if (isOwner) {
        final result = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendNft(
              nftInfo: nftInfo,
              addressFrom: walletAddress.toLowerCase(),
              imageWallet: '',
              nameWallet: '',
              pageRouter: PageRouter.MY_ACC,
            ),
            settings: const RouteSettings(
              name: AppRouter.send_nft,
            ),
          ),
        );
        result.then((value) {
          if (value != null) {
            nftMarket.processStatus = 3;
            bloc.emit(NftNotOnMarketSuccess(nftMarket));
            Timer(const Duration(seconds: 30), () {
              bloc.emit(NFTDetailInitial());
              nftMarket.processStatus = 0;
              bloc.emit(NftNotOnMarketSuccess(nftMarket));
              showDialogSuccess(
                context,
                alert: S.current.transfer_success,
                text: S.current.transfer_success_to + value.toString(),
              );
            });
          }
        });
      } else {
        showAlert(context, walletAddress);
      }
    },
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: roundButton(image: ImageAssets.ic_transfer_svf),
    ),
  );
}

Widget _nameNFT({
  required String title,
  int quantity = 1,
  String url = '',
  double? price,
  required BuildContext context,
}) {
  return Container(
    margin: EdgeInsets.only(
      top: 8.h,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: textNormalCustom(null, 24, FontWeight.w600),
              ),
            ),
            SizedBox(
              width: 25.h,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ComingSoon();
                    },
                  ),
                );
              },
              child: roundButton(
                image: ImageAssets.ic_flag_svg,
                whiteBackground: true,
              ),
            ),
            SizedBox(
              width: 20.h,
            ),
            InkWell(
              onTap: () {
                Share.share(url, subject: 'Buy NFT with $price USD');
              },
              child: roundButton(
                image: ImageAssets.ic_share_svg,
                whiteBackground: true,
              ),
            ),
          ],
        ),
        Text(
          '1 of $quantity ${S.current.available}',
          textAlign: TextAlign.left,
          style: tokenDetailAmount(
            fontSize: 16,
          ),
        ),
        spaceH12,
        line,
      ],
    ),
  );
}

Widget _description(String des) {
  if (des.isNotEmpty) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        des.parseHtml(),
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          14,
          FontWeight.w400,
        ),
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}

Widget additionalColumn(List<Properties> properties) {
  if (properties.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.additional,
          style: textNormalCustom(
            AppTheme.getInstance().textThemeColor(),
            16,
            FontWeight.w600,
          ),
        ),
        spaceH14,
        Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            children: properties
                .map(
                  (e) => SizedBox(
                    height: 50.h,
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppTheme.getInstance()
                              .divideColor()
                              .withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      backgroundColor: AppTheme.getInstance().bgBtsColor(),
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.key ?? '',
                            textAlign: TextAlign.left,
                            style: textNormalCustom(
                              AppTheme.getInstance()
                                  .textThemeColor()
                                  .withOpacity(0.7),
                              12,
                              FontWeight.w400,
                            ),
                          ),
                          spaceH4,
                          Text(
                            e.value ?? '',
                            textAlign: TextAlign.left,
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              14,
                              FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  } else {
    return const SizedBox.shrink();
  }
}

Widget _rowCollection(String symbol, String collectionName, bool verify) {
  return Row(
    children: [
      SizedBox(
        height: 28.h,
        width: 28.w,
        child: CircleAvatar(
          backgroundColor: Colors.yellow,
          radius: 18.r,
          child: Center(
            child: Text(
              collectionName.substring(0, 1),
              style: textNormalCustom(
                Colors.black,
                20,
                FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        width: 8.w,
      ),
      Text(
        collectionName,
        style: textNormalCustom(
          Colors.white,
          16,
          FontWeight.w400,
        ),
      ),
      SizedBox(
        width: 8.w,
      ),
      if (verify) ...[
        sizedSvgImage(w: 16.w, h: 16.h, image: ImageAssets.ic_verify_svg)
      ]
    ],
  );
}

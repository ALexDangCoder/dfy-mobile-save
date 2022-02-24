import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/list_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/ui/evaluation_result.dart';
import 'package:Dfy/presentation/create_hard_nft/receive_hard_nft/ui/receive_hard_nft_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MintRequestItem extends StatelessWidget {
  const MintRequestItem({Key? key, required this.mintRequestModel})
      : super(key: key);

  final MintRequestModel mintRequestModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (mintRequestModel.status) {
          case 3:
          case 4:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EvaluationResult(
                  assetID: mintRequestModel.id ?? '',
                  pageRouter: PageRouterHardNFT.LIST_HARD,
                ),
                settings: const RouteSettings(
                  name: AppRouter.step3ListEvaluation,
                ),
              ),
            );
            break;
          case 5:
          case 6:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ReceiveHardNFTScreen(
                  assetId: mintRequestModel.id ?? '',
                ),
              ),
            );
            break;
          default:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ListBookEvaluation(
                  assetId: mintRequestModel.id ?? '',
                  pageRouter: PageRouterHardNFT.LIST_HARD,
                ),
                settings: const RouteSettings(
                  name: AppRouter.step2ListBook,
                ),
              ),
            );
        }
      },
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: 64.h,
              width: 64.w,
              decoration: BoxDecoration(
                color: colorTextField,
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(
                    getImage(mintRequestModel.assetType?.id ?? 0),
                  ),
                ),
              ),
            ),
            spaceW16,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mintRequestModel.name ?? '',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    20,
                    FontWeight.w600,
                  ),
                  overflow: TextOverflow.clip,
                ),
                spaceH4,
                Text(
                  mintRequestModel.assetType?.name ?? '',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                  overflow: TextOverflow.clip,
                ),
                spaceH4,
                Row(
                  children: [
                    Text(
                      S.current.expect_for,
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    spaceW8,
                    SizedBox(
                      height: 16.h,
                      width: 16.w,
                      child: Image.network(
                        mintRequestModel.urlToken ?? '',
                      ),
                    ),
                    spaceW4,
                    Text(
                      '${mintRequestModel.expectingPrice} '
                      '${mintRequestModel.expectingPriceSymbol}',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
                spaceH4,
                getStatus(mintRequestModel.status ?? 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getImage(int assetId) {
    switch (assetId) {
      case 0:
        return ImageAssets.diamond44;
      case 2:
        return ImageAssets.artwork44;
      case 4:
        return ImageAssets.car44;
      case 1:
        return ImageAssets.watch44;
      case 3:
        return ImageAssets.house44;
      default:
        return ImageAssets.other44;
    }
  }

  Widget getStatus(int status) {
    switch (status) {
      case 3:
      case 5:
        return Text(
          S.current.processing_transaction,
          style: textNormalCustom(
            greenMarketColor,
            16,
            FontWeight.w400,
          ),
          overflow: TextOverflow.clip,
        );
      case 6:
        return Text(
          S.current.nft_created,
          style: textNormalCustom(
            greenMarketColor,
            16,
            FontWeight.w400,
          ),
          overflow: TextOverflow.clip,
        );
      case 4:
        return Text(
          S.current.evaluated,
          style: textNormalCustom(
            greenMarketColor,
            16,
            FontWeight.w400,
          ),
          overflow: TextOverflow.clip,
        );
      default:
        return Text(
          S.current.un_evaluated,
          style: textNormalCustom(
            redMarketColor,
            16,
            FontWeight.w400,
          ),
          overflow: TextOverflow.clip,
        );
    }
  }
}

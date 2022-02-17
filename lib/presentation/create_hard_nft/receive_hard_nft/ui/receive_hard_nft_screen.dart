import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReceiveHardNFTScreen extends StatelessWidget {
  const ReceiveHardNFTScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String name = 'Sapphire ring';
    const String collectName = 'BDA collection BDA  BDA col BDA collectionlect ion BDA collection BDA collection';
    const String imageHardNFT =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK25oTmIzw89odLosYAi8BSlB1ipKUn7Re23Y6X2pq98Fab8RaQqqINUyMfkA9I8KWgmA&usqp=CAU';
    const String imageCollection =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK25oTmIzw89odLosYAi8BSlB1ipKUn7Re23Y6X2pq98Fab8RaQqqINUyMfkA9I8KWgmA&usqp=CAU';
    const String priceHardNFT = '100,150,0.69';
    const String tokenSymbol = 'DFY';
    final String tokenIcon = ImageAssets.getSymbolAsset('DFY');
    const bool isVerify = true;
    return BaseDesignScreen(
      isImage: true,
      text: ImageAssets.ic_close,
      onRightClick: () {
        Navigator.pop(context);
      },
      title: S.current.receive_hard_nft,
      bottomBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: ButtonGold(
                title: S.current.view_detail_nft,
                isEnable: true,
              ),
            ),
            const SizedBox(
              height: 38,
            )
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH24,
            const StepFourAppBar(),
            spaceH32,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: SizedBox(
                child: Text(
                  S.current.hard_nft_is_coming_to_your_wallet,
                  style: textNormalCustom(
                    AppTheme.getInstance().grayTextColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                bottom: 12,
                top: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Image(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                          imageHardNFT,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 32,
                      child: SvgPicture.asset(
                        ImageAssets.hard_nft_note_svg,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                name,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  24,
                  FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    height: 20,
                    width: 20,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        imageCollection,
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: collectName,
                            style: textNormalCustom(
                              AppTheme.getInstance().whiteColor(),
                              16,
                              FontWeight.w600,
                            ),
                          ),
                          WidgetSpan(
                            child: isVerify
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: sizedSvgImage(
                                      w: 16,
                                      h: 16,
                                      image: ImageAssets.ic_verify_svg,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    child: Text(
                      '1 of 1',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    height: 28,
                    width: 28,
                    child: Image.asset(tokenIcon),
                  ),
                  Text(
                    '$priceHardNFT $tokenSymbol',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      20,
                      FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepFourAppBar extends StatelessWidget {
  const StepFourAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SuccessCkcCreateNft(),
        dividerSuccessCreateNFT,
        const SuccessCkcCreateNft(),
        dividerCreateNFT,
        const SuccessCkcCreateNft(),
        dividerCreateNFT,
        CircleStepCreateNft(
          circleStatus: CircleStatus.IS_CREATING,
          stepCreate: S.current.step4,
        ),
      ],
    );
  }
}

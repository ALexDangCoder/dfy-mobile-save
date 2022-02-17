import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart' as style;
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/receive_hard_nft/bloc/receive_hard_nft_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/receive_hard_nft/bloc/receive_hard_nft_state.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/step1__when_submit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReceiveHardNFTScreen extends StatelessWidget {
  const ReceiveHardNFTScreen({Key? key, required this.assetId})
      : super(key: key);
  final String assetId;

  @override
  Widget build(BuildContext context) {
    final ReceiveHardNFTCubit cubit = ReceiveHardNFTCubit();
    return BlocBuilder<ReceiveHardNFTCubit, ReceiveHardNFTState>(
      bloc: cubit,
      builder: (BuildContext context, state) {
        if (state is ReceiveHardNFTLoaded) {
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
                      MarketType status = MarketType.NOT_ON_MARKET;
                      if (state.data.status == 2) {
                        status = MarketType.AUCTION;
                      } else if (state.data.status == 3) {
                        status = MarketType.PAWN;
                      } else if (state.data.status == 1) {
                        status = MarketType.SALE;
                      }
                      goTo(
                        context,
                        NFTDetailScreen(
                          typeMarket: status,
                          typeNft: TypeNFT.HARD_NFT,
                          nftId: state.data.nftAssetHard?.nftId,
                          nftTokenId: state.data.nftAssetHard?.bcTokenId.toString(),
                        ),
                      );
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
                  style.spaceH24,
                  const StepFourAppBar(),
                  style.spaceH32,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: SizedBox(
                      child: Text(
                        S.current.hard_nft_is_coming_to_your_wallet,
                        style: style.textNormalCustom(
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
                            child: Image(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(
                                ApiConstants.BASE_URL_IMAGE +
                                    (state.data.nftAssetHard?.mediaId ?? ''),
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
                      state.data.name ?? '',
                      style: style.textNormalCustom(
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
                            color: Colors.yellow
                          ),
                          child: Center(
                            child: Text(
                              (state.data.collection?.name?? '').substring(0, 1),
                              style: textNormalCustom(
                                Colors.black,
                                16,
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: state.data.collection?.name ?? '',
                                  style: style.textNormalCustom(
                                    AppTheme.getInstance().whiteColor(),
                                    16,
                                    FontWeight.w600,
                                  ),
                                ),
                                WidgetSpan(
                                  child: (state.data.collection?.isWhitelist ?? false)
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
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
                            '1 of ${state.data.nftAssetHard?.numberOfCopies ?? ''}',
                            style: style.textNormalCustom(
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
                          child: Image.asset(ImageAssets.getSymbolAsset(
                              state.data.expectingPriceSymbol ?? 'DFY')),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${formatValue.format(state.data.expectingPrice)} ${state.data.expectingPriceSymbol}',
                          style: style.textNormalCustom(
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
        } else if (state is ReceiveHardNFTLoading) {
          return BaseDesignScreen(
            isImage: true,
            text: ImageAssets.ic_close,
            onRightClick: () {
              Navigator.pop(context);
            },
            title: S.current.receive_hard_nft,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  style.spaceH24,
                  const StepFourAppBar(),
                  style.spaceH32,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: SizedBox(
                      child: Text(
                        S.current.hard_nft_is_coming_to_your_wallet,
                        style: style.textNormalCustom(
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
                    child: Container(
                      width: double.infinity,
                      height: 250.h,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.getInstance().skeletonLight(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 25,
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppTheme.getInstance().skeletonLight(),
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
                            color: AppTheme.getInstance().skeletonLight(),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppTheme.getInstance().skeletonLight(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppTheme.getInstance().skeletonLight(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          height: 28,
                          width: 28,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppTheme.getInstance().skeletonLight(),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 25,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppTheme.getInstance().skeletonLight(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Material(
            child: Container(
              color: AppTheme.getInstance().backgroundBTSColor(),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 54,
                      width: 54,
                      child: Image.asset(ImageAssets.err_load_category),
                    ),
                    const SizedBox(height: 24),
                    Flexible(
                      child: Text(
                        S.current.could_not_load_data,
                        style: style.textNormalCustom(
                          textErrorLoad,
                          13.sp,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      onTap: () {
                        cubit.getAssetHardNFT(
                            assetId: '620384b24aec3de4976bbbb5');
                      },
                      child: SizedBox(
                        height: 36,
                        width: 36,
                        child: Image.asset(ImageAssets.reload_category),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
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
        style.dividerSuccessCreateNFT,
        const SuccessCkcCreateNft(),
        style.dividerSuccessCreateNFT,
        const SuccessCkcCreateNft(),
        style.dividerCreateNFT,
        CircleStepCreateNft(
          circleStatus: CircleStatus.IS_CREATING,
          stepCreate: S.current.step4,
        ),
      ],
    );
  }
}

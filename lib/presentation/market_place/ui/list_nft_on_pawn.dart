import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/list_nft/ui/list_nft.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:Dfy/presentation/nft_on_pawn/ui/detail_nft_on_pawn/detail_nft_on_pawn.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/error_nft_collection_explore/error_load_nft.dart';
import 'package:Dfy/widgets/skeleton/skeleton_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListNftOnPawn extends StatelessWidget {
  const ListNftOnPawn({
    Key? key,
    required this.cubit,
    required this.isLoading,
    required this.isLoadFail,
  }) : super(key: key);
  final MarketplaceCubit cubit;
  final bool isLoading;
  final bool isLoadFail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //text nfts collateral and btn arrow
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.NFTs_collateral,
                style: textNormalCustom(
                  Colors.white,
                  20.sp,
                  FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () {
                  isLoading
                      ? () {}
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ListNft(marketType: MarketType.PAWN),
                          ),
                        );
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 16.w,
                  ),
                  child: Image(
                    height: 32.h,
                    width: 32.w,
                    image: const AssetImage(
                      ImageAssets.img_push,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        //list nft on pawn
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 231.h,
            child: isLoadFail
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            ErrorLoadNft(
                              callback: () {
                                cubit.getListNftCollectionExplore();
                              },
                            ),
                            spaceW12,
                          ],
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: isLoading ? 6 : cubit.nftsCollateral.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          isLoading
                              ? () {}
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OnPawn(),
                                  ),
                                );
                        },
                        child: Row(
                          children: [
                            if (isLoading)
                              const SkeletonNft()
                            else
                              NFTItemWidget(
                                nftMarket: cubit.nftsCollateral[index],
                              ),
                            spaceW12,
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/list_nft/ui/list_nft.dart';
import 'package:Dfy/presentation/market_place/ui/market_place_screen.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/error_nft_collection_explore/error_load_nft.dart';
import 'package:Dfy/widgets/skeleton/skeleton_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListFeaturedNft extends StatelessWidget {
  const ListFeaturedNft({
    Key? key,
    required this.cubit,
    required this.isLoading,
    required this.isLoadFail,
    required this.marketType,
  }) : super(key: key);
  final MarketplaceCubit cubit;
  final bool isLoading;
  final bool isLoadFail;
  final String marketType;

  @override
  Widget build(BuildContext context) {
    final MarketType? marketTypeEnum;
    switch (marketType) {
      case 'sale':
        marketTypeEnum = MarketType.SALE;
        break;
      case 'auction':
        marketTypeEnum = MarketType.AUCTION;
        break;
      case 'pawn':
        marketTypeEnum = MarketType.PAWN;
        break;
      default:
        marketTypeEnum = null;
        break;
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured NFTs',
                style: textNormalCustom(
                  Colors.white,
                  20.sp,
                  FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  isLoading
                      ? () {}
                      : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ListNft(marketType: marketTypeEnum),
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
        //list nft aution
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 231.h,
            child: isLoadFail
                ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
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
              itemCount: isLoading
                  ? 6
                  : (cubit.nftsFeaturedNfts.length > 6)
                  ? 6
                  : cubit.nftsFeaturedNfts.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // isLoading
                    //     ? () {}
                    //     : () {//todo}
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const OnAuction(),
                    //   ),
                    // );
                  },
                  child: Row(
                    children: [
                      if (isLoading)
                        const SkeletonNft()
                      else
                        NFTItemWidget(
                          nftMarket: cubit.nftsFeaturedNfts[index],
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

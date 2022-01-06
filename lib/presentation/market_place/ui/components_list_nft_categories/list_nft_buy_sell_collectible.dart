import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/error_nft_collection_explore/error_load_nft.dart';
import 'package:Dfy/widgets/skeleton/skeleton_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListNftBuySellCollectible extends StatelessWidget {
  const ListNftBuySellCollectible({
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
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  S.current.buy_sell_create_collectible_nfts,
                  style: textNormalCustom(
                    Colors.white,
                    20.sp,
                    FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // isLoading
                  //     ? () {}
                  //     : Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //     const ListNft(marketType: MarketType.AUCTION),
                  //   ),
                  // );
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
                  : (cubit.nftsBuySellCreateCollectible.length > 6)
                  ? 6
                  : cubit.nftsBuySellCreateCollectible.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // isLoading
                    //     ? () {}
                    //     : Navigator.push(
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
                          nftMarket: cubit.nftsBuySellCreateCollectible[index],
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
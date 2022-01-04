import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/hard_nft_screen.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/error_nft_collection_explore/error_load_nft.dart';
import 'package:Dfy/widgets/skeleton/skeleton_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListNftHard extends StatelessWidget {
  const ListNftHard({
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
        //txt hard nft and btn arrow
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.hard_NFT,
                style: textNormalCustom(
                  Colors.white,
                  20.sp,
                  FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () {
                  //todo chờ a hưng thiết kế phát
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
        //list hard nft
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
                    itemCount: isLoading ? 6 : cubit.nftsHardNft.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return HardNFTScreen(
                                  bloc: HardNFTBloc(),
                                  isAuction: true,
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              if (isLoading)
                                const SkeletonNft()
                              else
                                NFTItemWidget(
                                  nftMarket: cubit.nftsHardNft[index],
                                ),
                              spaceW12,
                            ],
                          ));
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

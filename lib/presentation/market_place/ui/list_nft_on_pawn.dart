import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:Dfy/presentation/nft_on_pawn/ui/detail_nft_on_pawn/detail_nft_on_pawn.dart';
import 'package:Dfy/presentation/nft_on_pawn/ui/nft_list_on_pawn/nft_list_on_pawn.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ListNftOnPawn extends StatelessWidget {
  const ListNftOnPawn({Key? key, required this.cubit}) : super(key: key);
  final MarketplaceCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //text nfts collateral and btn arrow
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const NftListOnPawn(),
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
              cubit.listFakeDataCollateral.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const OnPawn(),
                      ),
                    );
                  },
                  child: NFTItemWidget(
                    name: cubit
                        .listFakeDataCollateral[index].name,
                    price: cubit
                        .listFakeDataCollateral[index]
                        .price,
                    propertiesNFT: TypePropertiesNFT.PAWN,
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

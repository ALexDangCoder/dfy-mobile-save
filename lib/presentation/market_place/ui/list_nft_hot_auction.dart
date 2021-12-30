import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/grid_view_auction.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/nft_detail_on_auction.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ListNftHotAuction extends StatelessWidget {
  const ListNftHotAuction({Key? key, required this.cubit,}) : super(key: key);
  final MarketplaceCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //text  hot aution and btn arrow
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.hot_auction,
                style: textNormalCustom(
                  Colors.white,
                  20.sp,
                  FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const GridViewAuction(),
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
              cubit.listFakeDataHotAuction.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const OnAuction(),
                      ),
                    );
                  },
                  child: NFTItemWidget(
                    name: cubit
                        .listFakeDataHotAuction[index].name,
                    price: cubit
                        .listFakeDataHotAuction[index]
                        .price,
                    propertiesNFT:
                    TypePropertiesNFT.AUCTION,
                    typeNFT: cubit
                        .listFakeDataHotAuction[index]
                        .typeNFT,
                    hotAuction: TypeHotAuction.YES,
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

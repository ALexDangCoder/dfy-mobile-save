import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/hard_nft_screen.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ListNftHard extends StatelessWidget {
  const ListNftHard({Key? key, required this.cubit}) : super(key: key);
  final MarketplaceCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //txt hard nft and btn arrow
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
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
                onTap: () {},
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cubit.listFakeDataHardNFT.length,
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
                  child: NFTItemWidget(
                    name: cubit
                        .listFakeDataHardNFT[index].name,
                    price: cubit
                        .listFakeDataHardNFT[index].price,
                    propertiesNFT: cubit
                        .listFakeDataHardNFT[index]
                        .propertiesNFT,
                    typeNFT: TypeNFT.HARD_NFT,
                    hotAuction: cubit
                        .listFakeDataHardNFT[index]
                        .hotAuction,
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

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/category.dart';
import 'package:Dfy/presentation/market_place/ui/collection_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypePropertiesNFT { PAWN, AUCTION, SALE }
enum TypeImage { IMAGE, VIDEO }
enum TypeNFT { HARD_NFT }
enum TypeHotAuction { YES, NO }

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({Key? key}) : super(key: key);

  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlaceScreen> {
  late MarketplaceCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = MarketplaceCubit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppTheme.getInstance().listBackgroundMarketColor(),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            SizedBox(
              height: 14.h,
            ),
            Divider(
              color: AppTheme.getInstance().divideColor(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                ),
                child: SizedBox(
                  height: 699.h,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          'Outstanding collection',
                          style: textNormalCustom(
                            Colors.white,
                            20,
                            FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 147.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.listCollections.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CollectionItem(
                                urlIcon: cubit.listCollections[index].avatar,
                                title: cubit.listCollections[index].title,
                                urlBackGround:
                                    cubit.listCollections[index].background,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hot auction',
                              style: textNormalCustom(
                                Colors.white,
                                20,
                                FontWeight.w700,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 16.w,
                                ),
                                child: const Image(
                                  image: AssetImage(ImageAssets.img_push),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 231.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.listFakeDataHotAuction.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return NFTItemWidget(
                                name: cubit.listFakeDataHotAuction[index].name,
                                price:
                                    cubit.listFakeDataHotAuction[index].price,
                                propertiesNFT: TypePropertiesNFT.AUCTION,
                                typeNFT:
                                    cubit.listFakeDataHotAuction[index].typeNFT,
                                hotAuction: TypeHotAuction.YES,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'NFTs collateral',
                              style: textNormalCustom(
                                Colors.white,
                                20,
                                FontWeight.w700,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 16.w,
                                ),
                                child: const Image(
                                  image: AssetImage(ImageAssets.img_push),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 231.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.listFakeDataCollateral.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return NFTItemWidget(
                                name: cubit.listFakeDataCollateral[index].name,
                                price:
                                    cubit.listFakeDataCollateral[index].price,
                                propertiesNFT: TypePropertiesNFT.PAWN,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sale items',
                              style: textNormalCustom(
                                Colors.white,
                                20,
                                FontWeight.w700,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 16.w,
                                ),
                                child: const Image(
                                  image: AssetImage(ImageAssets.img_push),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 231.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.listFakeDataCollateral.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return NFTItemWidget(
                                name: cubit.listFakeDataCollateral[index].name,
                                price:
                                    cubit.listFakeDataCollateral[index].price,
                                propertiesNFT: TypePropertiesNFT.SALE,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hard NFT',
                              style: textNormalCustom(
                                Colors.white,
                                20,
                                FontWeight.w700,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 16.w,
                                ),
                                child: const Image(
                                  image: AssetImage(ImageAssets.img_push),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 231.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.listFakeDataHardNFT.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return NFTItemWidget(
                                name: cubit.listFakeDataHardNFT[index].name,
                                price: cubit.listFakeDataHardNFT[index].price,
                                propertiesNFT: cubit
                                    .listFakeDataHardNFT[index].propertiesNFT,
                                typeNFT: TypeNFT.HARD_NFT,
                                hotAuction:
                                    cubit.listFakeDataHardNFT[index].hotAuction,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Text(
                          'Explore categories',
                          style: textNormalCustom(
                            Colors.white,
                            20,
                            FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 130.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Category(
                                title: cubit.categories[index],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        SizedBox(
                          height: 164.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.only(top: 44.h, left: 16.h),
      child: Container(
        height: 52.h,
        width: 343.w,
        color: Colors.white,
      ),
    );
  }
}

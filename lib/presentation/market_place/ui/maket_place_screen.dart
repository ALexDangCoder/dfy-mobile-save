import 'dart:developer';
import 'dart:math';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/hard_nft_screen.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/grid_view_auction.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/nft_detail_on_auction.dart';
import 'package:Dfy/presentation/market_place/ui/category.dart';
import 'package:Dfy/presentation/market_place/ui/collection_item.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:Dfy/presentation/nft_on_pawn/ui/detail_nft_on_pawn/detail_nft_on_pawn.dart';
import 'package:Dfy/presentation/nft_on_pawn/ui/nft_list_on_pawn/nft_list_on_pawn.dart';
import 'package:Dfy/presentation/nft_on_sale/ui/detail_nft/on_sale_detail.dart';
import 'package:Dfy/presentation/nft_on_sale/ui/nft_list_on_sale/ui/nft_list.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../search/ui/nft_search.dart';

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
    return BlocBuilder<MarketplaceCubit, MarketplaceState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is OnSearch) {
          return SearchNFT(
            cubit: cubit,
          );
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.current.outstanding_collection,
                                    style: textNormalCustom(
                                      Colors.white,
                                      20.sp,
                                      FontWeight.w700,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRouter.collectionList,
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
                                      urlIcon:
                                          cubit.listCollections[index].avatar,
                                      title: cubit.listCollections[index].title,
                                      urlBackGround: cubit
                                          .listCollections[index].background,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              Row(
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
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
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
                              SizedBox(
                                height: 32.h,
                              ),
                              Row(
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
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
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
                                            .listFakeDataCollateral[index].price,
                                        propertiesNFT: TypePropertiesNFT.PAWN,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.current.sale_items,
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
                                          const NFTListOnSale(),
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
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                height: 231.h,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      cubit.listFakeDataCollateral.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const OnSale(),
                                          ),
                                        );
                                      },
                                      child: NFTItemWidget(
                                        name: cubit
                                            .listFakeDataCollateral[index].name,
                                        price: cubit
                                            .listFakeDataCollateral[index].price,
                                        propertiesNFT: TypePropertiesNFT.SALE,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              Row(
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
                                    return InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) {
                                            return HardNFTScreen(
                                              bloc: HardNFTBloc(),
                                              isAuction: Random().nextBool(),
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
                              SizedBox(
                                height: 32.h,
                              ),
                              Text(
                                S.current.explore_categories,
                                style: textNormalCustom(
                                  Colors.white,
                                  20.sp,
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
          ),
        );
      },
    );
  }

  Widget header() {
    return Padding(
      padding: EdgeInsets.only(
        top: 44.h,
        left: 16.h,
        right: 16.w,
      ),
      child: SizedBox(
        height: 52.h,
        width: 343.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: ImageIcon(
                const AssetImage(ImageAssets.ic_profile),
                size: 28.sp,
                color: AppTheme.getInstance().whiteColor(),
              ),
            ),
            searchBar(),
            GestureDetector(
              child: ImageIcon(
                const AssetImage(ImageAssets.ic_notify),
                size: 28.sp,
                color: AppTheme.getInstance().whiteColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return GestureDetector(
      onTap: () {
        cubit.emit(OnSearch());
      },
      child: Container(
        width: 259.w,
        height: 38.h,
        decoration: BoxDecoration(
          color: const Color(0xff4F4F65),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 14.w,
            ),
            Image.asset(
              ImageAssets.ic_search,
              width: 15.w,
              height: 15.h,
            ),
            SizedBox(
              width: 10.7.w,
            ),
            Text(
              S.current.search,
              style: textNormal(
                Colors.white54,
                16.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}

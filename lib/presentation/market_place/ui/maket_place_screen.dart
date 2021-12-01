import 'dart:math';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/hard_nft/evaluation_model.dart';
import 'package:Dfy/domain/model/hard_nft/hard_nft_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/hard_nft_screen.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/grid_view_auction.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/nft_detail_on_auction.dart';
import 'package:Dfy/presentation/market_place/search/ui/nft_search.dart';
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
                    child: SizedBox(
                      height: 699.h,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 24.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Row(
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
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: SizedBox(
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
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
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
                                                const OnAuction(
                                                ),
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
                            SizedBox(
                              height: 32.h,
                            ),
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
                            SizedBox(
                              height: 32.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Row(
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
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
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
                                    return InkWell(
                                      onTap: () {
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
                                            .listFakeDataCollateral[index]
                                            .price,
                                        propertiesNFT: TypePropertiesNFT.SALE,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
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
                                              hardNFT: HardNFTModel(
                                                image: 'https://phelieuminhhuy.com/wp-content/uploads/2015/07/7f3ce033-'
                                                    'b9b2-4259-ba7c-f6e5bae431a9-1435911423691.jpg',
                                                name: 'Lamborghini Aventador Pink Ver 2021',
                                                amount: 1,
                                                isAuction: true,
                                                endTime: DateTime(2021,12,31),
                                                loan: 120000,
                                                reservePrice: 240000,
                                                des: 'Kidzone ride on is the perfect gift for your child for any'
                                                    'occasion. Adjustable seat belt to ensure security during '
                                                    'driving. Rechargeable battery with 40-50 mins playtime.'
                                                    'Charing time: 8-10 hours,'
                                                    'Product Dimension (Inch): 42.52" x 24.41" x 15.75',
                                                collection: 'Defi For You',
                                                owner: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
                                                contract: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
                                                nftTokenID: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
                                                nftStandard: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
                                                blocChain: 'Binance BlocChain',
                                                evaluation: EvaluationModel(
                                                  by: 'The London Evaluation',
                                                  time: DateTime.now(),
                                                  maxAmount: 1200000,
                                                  depreciation: 20,
                                                  conclusion: 'Fast & furious',
                                                  images: [
                                                    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-Coupe-1-3961-1625659942.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=ea17Gz8qHY-aIVS-Ev73xg',
                                                    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-3-4-Rear-988-8401-6806-1625659942.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=IOBRMVVPbJ2V3bAikJK3Vg',
                                                    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-Front-5556-1-3532-3841-1625659942.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=BEL11PJgSu5diDe9c1QJig',
                                                    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-Rear-1848-16-6335-6733-1625659942.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=tJHxvyrGwIW7kVTciDgThw',
                                                    'https://img.tinbanxe.vn/images/Lamborghini/Lamborghini%20Aventador%20SVJ/mau-sac/lamborghini-aventador-mau-cam-dam-tinbanxe.jpg',
                                                    'https://img.tinbanxe.vn/images/Lamborghini/Lamborghini%20Aventador%20SVJ/mau-sac/lamborghini-aventador-mau-den-tinbanxe.jpg',
                                                    'https://img.tinbanxe.vn/images/Lamborghini/Lamborghini%20Aventador%20SVJ/mau-sac/lamborghini-aventador-mau-trang-tinbanxe.jpg',
                                                    'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_960_720.jpg',
                                                    'https://media.istockphoto.com/photos/flora-of-gran-canaria-flowering-marguerite-daisy-picture-id1072462590',
                                                    'https://news.cgtn.com/news/2020-09-20/Spider-flower-The-flower-with-a-distinctive-display-TVYLozFKg0/img/9c42156e261a4d2282370c03fce43a0a/9c42156e261a4d2282370c03fce43a0a.jpeg',
                                                    'https://news.cgtn.com/news/2020-09-20/Spider-flower-The-flower-with-a-distinctive-display-TVYLozFKg0/img/eab3d2c3f58c4ba8b7fc8a7ca2957edf/eab3d2c3f58c4ba8b7fc8a7ca2957edf.jpeg',
                                                    'https://news.cgtn.com/news/2020-09-20/Spider-flower-The-flower-with-a-distinctive-display-TVYLozFKg0/img/13cdba1b208b4e1cae15bd4f7f1fdc59/13cdba1b208b4e1cae15bd4f7f1fdc59.jpeg',
                                                    'https://news.cgtn.com/news/2020-09-20/Spider-flower-The-flower-with-a-distinctive-display-TVYLozFKg0/img/da3aaec388854a5eadbfe73f86dfdca2/da3aaec388854a5eadbfe73f86dfdca2.jpeg'
                                                  ],
                                                ),
                                              ),

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
                            SizedBox(
                              height: 32.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Text(
                                S.current.explore_categories,
                                style: textNormalCustom(
                                  Colors.white,
                                  20.sp,
                                  FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: SizedBox(
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

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/search/ui/nft_search.dart';
import 'package:Dfy/presentation/market_place/ui/header.dart';
import 'package:Dfy/presentation/market_place/ui/list_explore_category.dart';
import 'package:Dfy/presentation/market_place/ui/list_nft_buy_sell_collectible.dart';
import 'package:Dfy/presentation/market_place/ui/list_nft_featured_soft.dart';
import 'package:Dfy/presentation/market_place/ui/list_nft_hard.dart';
import 'package:Dfy/presentation/market_place/ui/list_nft_hot_auction.dart';
import 'package:Dfy/presentation/market_place/ui/list_nft_on_pawn.dart';
import 'package:Dfy/presentation/market_place/ui/list_nft_on_sale.dart';
import 'package:Dfy/presentation/market_place/ui/list_outstanding_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    cubit.getListNftCollectionExplore();
    print('fucccccccccc');
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
        } else if (state is LoadingDataLoading) {
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
                  HeaderMarketPlace(cubit: cubit),
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
                            ListOutstandingCollection(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: false,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftHotAuction(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: false,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftOnPawn(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: false,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftOnSale(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: false,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftHard(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: false,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListExploreCategory(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: false,
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
          );
        } else if (state is LoadingDataSuccess) {
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
                    HeaderMarketPlace(cubit: cubit),
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
                              //this code will display list collection, nfts,
                              // explore category
                              //priority by position in
                              // listCollectionFtExploreFtNft
                              for (Map<String, dynamic> e
                                  in cubit.listCollectionFtExploreFtNft)
                                if (e['name'] ==
                                    'Buy, sell, and create collectible NFTs') ...[
                                  ListNftBuySellCollectible(
                                    cubit: cubit,
                                    isLoading: false,
                                    isLoadFail: false,
                                  ),
                                  spaceH32,
                                ] else if (e['name'] ==
                                    'Featured Soft NFTs') ...[
                                  ListFeaturedSoftNft(
                                    cubit: cubit,
                                    isLoading: false,
                                    isLoadFail: false,
                                  ),
                                  spaceH32,
                                ] else if (e['name'] == 'Hot auction') ...[
                                  ListNftHotAuction(
                                    cubit: cubit,
                                    isLoading: false,
                                    isLoadFail: false,
                                  ),
                                  spaceH32,
                                ] else if (e['name'] ==
                                    'Outstanding collection') ...[
                                  ListOutstandingCollection(
                                    cubit: cubit,
                                    isLoading: false,
                                    isLoadFail: false,
                                  ),
                                  spaceH32,
                                ] else if (e['name'] == 'Sale items') ...[
                                  ListNftOnSale(
                                    cubit: cubit,
                                    isLoading: false,
                                    isLoadFail: false,
                                  ),
                                  spaceH32,
                                ] else if (e['name'] == 'NFTs collateral') ...[
                                  ListNftOnPawn(
                                    cubit: cubit,
                                    isLoading: false,
                                    isLoadFail: false,
                                  ),
                                  spaceH32,
                                ]
                                //this else handle explore categories
                                else ...[
                                  ListExploreCategory(
                                    cubit: cubit,
                                    isLoading: false,
                                    isLoadFail: false,
                                  ),
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                ],
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
        } else {
          //todo error
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
                  HeaderMarketPlace(cubit: cubit),
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
                            ListOutstandingCollection(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: true,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftHotAuction(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: true,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftOnPawn(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: true,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftOnSale(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: true,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftHard(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: true,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListExploreCategory(
                              cubit: cubit,
                              isLoading: true,
                              isLoadFail: true,
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
          );
        }
      },
    );
  }
}

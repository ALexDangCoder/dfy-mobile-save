import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/list_book_evaluation.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/market_place/search/ui/nft_search.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_explore_category.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_nft_buy_sell_collectible.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_nft_featured.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_nft_featured_soft.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_nft_hard.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_nft_hot_auction.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_nft_on_pawn.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_nft_on_sale.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_outstanding_collection.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/create_collection_screen.dart';
import 'package:Dfy/presentation/market_place/ui/header.dart';
import 'package:Dfy/widgets/floating_button/ui/float_btn_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({Key? key}) : super(key: key);

  @override
  _MarketPlaceState createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlaceScreen>
    with AutomaticKeepAliveClientMixin<MarketPlaceScreen> {
  late MarketplaceCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = MarketplaceCubit();
    cubit.getListNftCollectionExplore();
  }

  @override
  void dispose() {
    FABMarketBase.cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MarketplaceCubit, MarketplaceState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is OnSearch) {
          return SearchNFT(
            cubit: cubit,
          );
        } else if (state is LoadingDataLoading) {
          return RefreshIndicator(
            onRefresh: () async {
              cubit.clearAllBeforePullToRefresh();
              await cubit.getListNftCollectionExplore();
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
                                marketType: '',
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              ListNftOnPawn(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: false,
                                marketType: '',
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              ListNftOnSale(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: false,
                                marketType: '',
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
            ),
          );
        } else if (state is LoadingDataSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              cubit.clearAllBeforePullToRefresh();
              await cubit.getListNftCollectionExplore();
            },
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
                floatingActionButton: Padding(
                  padding: EdgeInsets.only(bottom: 114.h),
                  child: FABMarketBase(
                    collectionCallBack: () {
                      showDialog(
                        context: context,
                        builder: (_) => ConnectWalletDialog(
                          navigationTo: CreateCollectionScreen(
                            bloc: CreateCollectionCubit(),
                          ),
                          isRequireLoginEmail: false,
                        ),
                      );
                    },
                    nftCallBack: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListBookEvaluation(
                            assetID: '61e9096a4aec3d3977856bf9',
                            cityId: 1,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors:
                          AppTheme.getInstance().listBackgroundMarketColor(),
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

                                ///note
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
                                      marketType: e['market_type'],
                                    ),
                                    spaceH32,
                                  ] else if (e['name'] ==
                                      'Featured Soft NFTs') ...[
                                    ListFeaturedSoftNft(
                                      cubit: cubit,
                                      isLoading: false,
                                      isLoadFail: false,
                                      marketType: e['market_type'],
                                    ),
                                    spaceH32,
                                  ] else if (e['name'] == 'Hot auction') ...[
                                    ListNftHotAuction(
                                      cubit: cubit,
                                      isLoading: false,
                                      isLoadFail: false,
                                      marketType: e['market_type'],
                                    ),
                                    spaceH32,
                                  ] else if (e['name'] == 'Featured NFTs') ...[
                                    ListFeaturedNft(
                                      cubit: cubit,
                                      isLoading: false,
                                      isLoadFail: false,
                                      marketType: e['market_type'],
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
                                  ] else if (e['name'] == 'Sale items' ||
                                      e['name'] == 'Sell items') ...[
                                    ListNftOnSale(
                                      cubit: cubit,
                                      isLoading: false,
                                      isLoadFail: false,
                                      marketType: e['market_type'],
                                    ),
                                    spaceH32,
                                  ] else if (e['name'] ==
                                      'NFTs collateral') ...[
                                    ListNftOnPawn(
                                      cubit: cubit,
                                      isLoading: false,
                                      isLoadFail: false,
                                      marketType: e['market_type'],
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
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              cubit.clearAllBeforePullToRefresh();
              await cubit.getListNftCollectionExplore();
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
                                marketType: '',
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              ListNftOnPawn(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: true,
                                marketType: '',
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              ListNftOnSale(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: true,
                                marketType: '',
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
            ),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

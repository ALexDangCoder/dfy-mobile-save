import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/market_place/search/ui/nft_search.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_explore_category.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_nft_home.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_outstanding_collection.dart';
import 'package:Dfy/presentation/market_place/ui/header.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/create_collection_screen.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_nft_screen.dart';
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
  final listWidget = <Widget>[];

  @override
  void initState() {
    super.initState();
    cubit = MarketplaceCubit();
    cubit.getListNftCollectionExplore(cubit: cubit);
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
              await cubit.getListNftCollectionExplore(cubit: cubit);
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
                              ListNftHome(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: false,
                                marketType: '', listNft: [], title: '',
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              ListNftHome(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: false,
                                marketType: '',
                                  listNft: [], title: '',
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              ListNftHome(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: false,
                                marketType: '',
                                listNft: [], title: '',
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              ListNftHome(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: false,
                                listNft: [], title: '', marketType: '',
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
              await cubit.getListNftCollectionExplore(cubit: cubit);
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
                          settings: const RouteSettings(
                            name: AppRouter.create_collection,
                          ),
                          navigationTo: CreateCollectionScreen(
                            bloc: CreateCollectionCubit(),
                          ),
                          isRequireLoginEmail: false,
                        ),
                      );
                    },
                    nftCallBack: () {
                      showDialog(
                        context: context,
                        builder: (_) => ConnectWalletDialog(
                          settings: const RouteSettings(
                            name: AppRouter.create_nft,
                          ),
                          navigationTo: CreateNFTScreen(
                            cubit: CreateNftCubit(),
                          ),
                          isRequireLoginEmail: false,
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
                                for (final element in cubit.listWidgetHome) ...[element],
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
              await cubit.getListNftCollectionExplore(cubit: cubit);
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
                              ListNftHome(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: true,
                                marketType: '',
                                listNft: [], title: '',
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              ListNftHome(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: true,
                                marketType: '',
                                listNft: [], title: '',
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              ListNftHome(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: true,
                                marketType: '',
                                listNft: [], title: '',
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              ListNftHome(
                                cubit: cubit,
                                isLoading: true,
                                isLoadFail: true,
                                listNft: [], title: '', marketType: '',
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

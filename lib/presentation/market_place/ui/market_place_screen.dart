import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/search/ui/nft_search.dart';
import 'package:Dfy/presentation/market_place/ui/header.dart';
import 'package:Dfy/presentation/market_place/ui/list_explore_category.dart';
import 'package:Dfy/presentation/market_place/ui/list_nft_hard.dart';
import 'package:Dfy/presentation/market_place/ui/list_nft_hot_auction.dart';
import 'package:Dfy/presentation/market_place/ui/list_nft_on_pawn.dart';
import 'package:Dfy/presentation/market_place/ui/list_nft_on_sale.dart';
import 'package:Dfy/presentation/market_place/ui/list_outstanding_collection.dart';
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
                            ListOutstandingCollection(cubit: cubit),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftHotAuction(cubit: cubit),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftOnPawn(
                              cubit: cubit,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftOnSale(cubit: cubit),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListNftHard(cubit: cubit),
                            SizedBox(
                              height: 32.h,
                            ),
                            ListExploreCategory(
                              cubit: cubit,
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
}

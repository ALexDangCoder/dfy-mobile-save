import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/ui/collection_list.dart';
import 'package:Dfy/presentation/detail_collection/ui/detail_collection.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/list_nft/ui/list_nft.dart';
import 'package:Dfy/presentation/market_place/search/bloc/search_cubit.dart';
import 'package:Dfy/presentation/market_place/search/ui/results_search.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchNFT extends StatefulWidget {
  const SearchNFT({Key? key, required this.cubit}) : super(key: key);
  final MarketplaceCubit cubit;

  @override
  _SearchNFTState createState() => _SearchNFTState();
}

class _SearchNFTState extends State<SearchNFT> {
  TextEditingController controller = TextEditingController();
  bool showAllResult = false;
  late Timer _debounce;
  late SearchCubit searchCubit;

  @override
  void initState() {
    super.initState();
    searchCubit = SearchCubit();
    _debounce = Timer(const Duration(milliseconds: 1000), () {});
  }

  @override
  void dispose() {
    // controller.dispose();
    // _debounce.cancel();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: 375.w,
          height: 812.h,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: listBackgroundColor,
            ),
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 52.h,
                ),
                searchBar(),
                SizedBox(
                  height: 22.h,
                ),
                Divider(
                  color: AppTheme.getInstance().divideColor(),
                ),
                BlocBuilder<SearchCubit, SearchState>(
                  bloc: searchCubit,
                  builder: (context, state) {
                    if (state is SearchSuccess) {
                      return result();
                    } else if (state is SearchError) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 150.h),
                          child: Column(
                            children: [
                              Image(
                                image: const AssetImage(
                                  ImageAssets.img_search_empty,
                                ),
                                height: 120.h,
                                width: 120.w,
                              ),
                              SizedBox(
                                height: 17.7.h,
                              ),
                              Text(
                                S.current.no_result_found,
                                style: textNormal(
                                  Colors.white54,
                                  20.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is SearchLoading) {
                      return Padding(
                        padding: EdgeInsets.only(top: 170.h),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return SizedBox(
      width: 343.w,
      height: 38.h,
      child: Row(
        children: [
          SizedBox(
            width: 27.w,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // widget.cubit.getListNftCollectionExplore();
            },
            child: ImageIcon(
              const AssetImage(
                ImageAssets.ic_back,
              ),
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(
            width: 27.h,
          ),
          Expanded(
            child: Container(
              width: 299.w,
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
                    height: 16.h,
                    width: 16.w,
                  ),
                  SizedBox(
                    width: 10.7.w,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      onChanged: (value) {
                        searchCubit.show();
                        if (_debounce.isActive) _debounce.cancel();
                        searchCubit.clearCollectionsFtNftsAfterSearch();
                        _debounce =
                            Timer(const Duration(milliseconds: 1000), () {
                          searchCubit.getCollectionFeatNftBySearch(
                            query: value,
                          );
                        });
                      },
                      autofocus: true,
                      cursorColor: Colors.white,
                      style: textNormal(
                        Colors.white,
                        16.sp,
                      ),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding:   EdgeInsets.zero,
                        hintText: S.current.search,
                        hintStyle: textNormal(
                          Colors.white54,
                          16.sp,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: searchCubit.isVisible,
                    builder: (context, snapshot) {
                      return Visibility(
                        visible: snapshot.data ?? false,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.text = '';
                              // searchCubit.clearCollectionsFtNftsAfterSearch();
                              _debounce =
                                  Timer(const Duration(milliseconds: 1000), () {
                                searchCubit.getCollectionFeatNftBySearch(
                                  query: '',
                                );
                              });
                              searchCubit.hide();
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 13.w,
                            ),
                            child: ImageIcon(
                              const AssetImage(
                                ImageAssets.ic_close,
                              ),
                              color: AppTheme.getInstance().whiteColor(),
                              size: 20.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget result() {
    return SizedBox(
      height: 699.h,
      width: 375.w,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.w),
              child: Text(
                S.current.collections,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  20.sp,
                  FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (searchCubit.collections.length > 3)
                  ? 3
                  : searchCubit.collections.length,
              itemBuilder: (context, index) {
                return searchCubit.collections.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => DetailCollection(
                                collectionAddress: searchCubit
                                    .collections[index].collectionAddress, typeScreen: PageRouter.MARKET,
                              ),
                            ),
                          );
                        },
                        child: ResultCollectionSearch(
                          collection: searchCubit.collections[index],
                        ),
                      )
                    : Container();
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Divider(
                    color: AppTheme.getInstance().divideColor(),
                  ),
                );
              },
            ),
            Visibility(
              visible: searchCubit.collections.isEmpty ? false : true,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 60.h,
                ),
                child: Column(
                  children: [
                    Divider(
                      color: AppTheme.getInstance().divideColor(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => CollectionList(
                              query: controller.text,
                              title: S.current.collection_search_result,
                              typeScreen: PageRouter.MARKET,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        S.current.view_all_result,
                        style: textNormalCustom(
                          AppTheme.getInstance().fillColor(),
                          16.sp,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: AppTheme.getInstance().divideColor(),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 17.w),
              child: Text(
                'NFTs',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  20.sp,
                  FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: (searchCubit.listNFT.length > 3)
                    ? 3
                    : searchCubit.listNFT.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      if (searchCubit.listNFT.isEmpty)
                        Container()
                      else
                        InkWell(
                          onTap: () {
                            //todo chuyen man sang man detail
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NFTDetailScreen(
                                  key: nftKey,
                                  typeMarket:
                                      searchCubit.listNFT[index].marketType!,
                                  marketId: searchCubit.listNFT[index].marketId,
                                  typeNft: searchCubit.listNFT[index].typeNFT,
                                  nftId: searchCubit.listNFT[index].nftId,
                                  pawnId: searchCubit.listNFT[index].pawnId,
                                  //todo fill nốt các trường vào
                                ),
                              ),
                            );
                          },
                          child: ResultNFTSearch(
                            nftItem: searchCubit.listNFT[index],
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: Divider(
                          color: AppTheme.getInstance().divideColor(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Visibility(
              visible: searchCubit.listNFT.isEmpty ? false : true,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 60.h,
                ),
                child: Center(
                  child: Column(
                    children: [
                      // Divider(
                      //   color: AppTheme.getInstance().divideColor(),
                      // ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              settings: const RouteSettings(
                                name: AppRouter.listNft,
                              ),
                              builder: (ctx) => ListNft(
                                queryAllResult: controller.text,
                                pageRouter: PageRouter.MARKET,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          S.current.view_all_result,
                          style: textNormalCustom(
                            AppTheme.getInstance().fillColor(),
                            16.sp,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 150.h,
            ),
          ],
        ),
      ),
    );
  }
}

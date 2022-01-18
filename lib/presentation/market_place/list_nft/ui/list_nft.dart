import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/market_place/create_collection/ui/create_collection_screen.dart';
import 'package:Dfy/presentation/market_place/list_nft/bloc/list_nft_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/presentation/nft_detail/ui/component/filter_bts.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/floating_button/ui/float_btn_add.dart';
import 'package:Dfy/widgets/skeleton/skeleton_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ListNft extends StatefulWidget {
  const ListNft({
    Key? key,
    this.marketType,
    this.queryAllResult,
  }) : super(key: key);
  final MarketType? marketType;
  final String? queryAllResult;

  @override
  _ListNftState createState() => _ListNftState();
}

class _ListNftState extends State<ListNft> {
  late ListNftCubit _cubit;
  TextEditingController controller = TextEditingController();
  late Timer _debounce;

  @override
  void initState() {
    super.initState();
    if(widget.queryAllResult?.isNotEmpty ?? false){
      controller.text = widget.queryAllResult!;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {});
    _cubit = ListNftCubit();
    _cubit.title.add(_cubit.getTitle(widget.marketType));
    _cubit.getTokenInf();
    _cubit.getAddressWallet(widget.marketType, widget.queryAllResult);
    _cubit.getCollectionFilter();

  }

  @override
  void dispose() {
    _cubit.close();
    controller.dispose();
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FABMarketBase(
        collectionCallBack: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CreateCollectionScreen(
                  bloc: CreateCollectionCubit(),
                );
              },
            ),
          );
        },
        nftCallBack: () {},
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: StreamBuilder<String>(
            stream: _cubit.title,
            builder: (context, AsyncSnapshot<String> snapshot) {
              return BaseBottomSheet(
                onRightClick: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.black,
                    isScrollControlled: true,
                    context: context,
                    builder: (_) {
                      return FilterBts(
                        listNftCubit: _cubit, isLogin: true,//_cubit.getLogin(),
                      );
                    },
                  );
                },
                isImage: true,
                title: snapshot.data ?? _cubit.getTitle(widget.marketType),
                text: ImageAssets.ic_filter,
                child: SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 12.h,
                          bottom: 6.h,
                        ),
                        child: searchBar(),
                      ),
                      NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (_cubit.canLoadMoreListNft &&
                              (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent)) {
                            _cubit.loadMorePosts();
                          }
                          return true;
                        },
                        child: BlocBuilder<ListNftCubit, ListNftState>(
                          bloc: _cubit,
                          builder: (context, state) {
                            if (state is ListNftSuccess ||
                                state is ListNftLoadMore ||
                                state is ListNftRefresh) {
                              if (_cubit.listData.isNotEmpty) {
                                return Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      _cubit.refreshPosts();
                                    },
                                    child: Stack(
                                      children: [
                                        StaggeredGridView.countBuilder(
                                          shrinkWrap: true,
                                          mainAxisSpacing: 20.h,
                                          itemCount: _cubit.listData.length,
                                          crossAxisCount: 2,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16.w),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: NFTItemWidget(
                                                  nftMarket:
                                                      _cubit.listData[index],
                                                ),
                                              ),
                                            );
                                          },
                                          staggeredTileBuilder: (int index) =>
                                              const StaggeredTile.fit(1),
                                        ),
                                        if (state is ListNftLoadMore)
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 520.h),
                                            child: Center(
                                              child: SizedBox(
                                                height: 24.h,
                                                width: 24.w,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2.r,
                                                  color: AppTheme.getInstance()
                                                      .whiteColor(),
                                                ),
                                              ),
                                            ),
                                          )
                                        else
                                          const SizedBox(),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
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
                                );
                              }
                            } else if (state is ListNftError) {
                              return Container();
                            } else if (state is ListNftLoading) {
                              return Expanded(
                                child: StaggeredGridView.countBuilder(
                                  shrinkWrap: true,
                                  mainAxisSpacing: 20.h,
                                  itemCount: 6,
                                  crossAxisCount: 2,
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: 16.w,
                                        right: 16.w,
                                      ),
                                      child: const SkeletonNft(),
                                    );
                                  },
                                  staggeredTileBuilder: (int index) {
                                    return const StaggeredTile.fit(1);
                                  },
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 343.w,
            height: 46.h,
            decoration: BoxDecoration(
              color: backSearch,
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
                      _cubit.show();
                      _onSearchChanged(value.trim());
                    },
                    cursorColor: Colors.white,
                    style: textNormal(
                      Colors.white,
                      16.sp,
                    ),
                    maxLength: 255,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: S.current.name_of_nft,
                      hintStyle: textNormal(
                        Colors.white54,
                        16.sp,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                StreamBuilder<bool>(
                  stream: _cubit.isVisible,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data ?? false,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.text = '';
                            _cubit.hide();
                          });
                          _cubit.getListNft(
                            status: _cubit.status(widget.marketType),
                          );
                          FocusScope.of(context).unfocus();
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
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 900), () {
      _cubit.searchNft(
        query,
        _cubit.getParam(_cubit.selectStatus),
      );
    });
  }
}

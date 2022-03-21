import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/list_nft/bloc/list_nft_cubit.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/create_collection_screen.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_nft_screen.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/nft_detail/ui/component/filter_bts.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/error_nft_collection_explore/error_load_nft.dart';
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
    required this.pageRouter,
    this.walletAddress,
  }) : super(key: key);
  final MarketType? marketType;
  final String? queryAllResult;
  final PageRouter pageRouter;
  final String? walletAddress;

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
    if (widget.queryAllResult?.isNotEmpty ?? false) {
      controller.text = widget.queryAllResult!;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {});
    _cubit = ListNftCubit();
    _cubit.title.add(_cubit.getTitle(widget.marketType));
    _cubit.getTokenInf();
    if (widget.pageRouter == PageRouter.MARKET) {
      _cubit.getCollectionFilter();
      if (widget.marketType != null) {
        _cubit.getListNft(
          status: _cubit.status(widget.marketType),
          pageRouter: PageRouter.MARKET,
        );
      } else {
        if (widget.queryAllResult != null) {
          _cubit.getListNft(
            name: widget.queryAllResult,
            pageRouter: PageRouter.MARKET,
          );
        } else {
          _cubit.getListNft(
            pageRouter: PageRouter.MARKET,
          );
        }
      }
    } else {
      _cubit.getListWallet();
      _cubit.walletAddress = widget.walletAddress!.toLowerCase();
      _cubit.addressStream.add(widget.walletAddress!.toLowerCase());
      if (widget.marketType != null) {
        _cubit.getListNft(
          status: _cubit.status(widget.marketType),
          walletAddress: widget.walletAddress,
          pageRouter: PageRouter.MY_ACC,
        );
      } else {
        if (widget.queryAllResult != null) {
          _cubit.getListNft(
            name: widget.queryAllResult,
            walletAddress: widget.walletAddress,
            pageRouter: PageRouter.MY_ACC,
          );
        } else {
          _cubit.getListNft(
            walletAddress: widget.walletAddress,
            pageRouter: PageRouter.MY_ACC,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _cubit.close();
    controller.dispose();
    _debounce.cancel();
    super.dispose();
  }

  void refresh() {
    _cubit.refreshPosts(widget.pageRouter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FABMarketBase(
        collectionCallBack: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(
                name: AppRouter.create_collection,
              ),
              builder: (context) {
                return CreateCollectionScreen(
                  bloc: CreateCollectionCubit(),
                );
              },
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

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     settings: const RouteSettings(
          //       name: AppRouter.create_nft,
          //     ),
          //     builder: (context) {
          //       return CreateNFTScreen(
          //         cubit: CreateNftCubit(),
          //       );
          //     },
          //   ),
          // );
        },
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
              return BaseDesignScreen(
                onRightClick: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.black,
                    isScrollControlled: true,
                    context: context,
                    builder: (_) {
                      return FilterBts(
                        listNftCubit: _cubit,
                        isLogin: widget.pageRouter == PageRouter.MY_ACC,
                        query: widget.queryAllResult ?? controller.value.text,
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
                      spaceH16,
                      NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (_cubit.canLoadMoreListNft &&
                              (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent)) {
                            _cubit.loadMorePosts(
                              widget.pageRouter,
                              controller.text.trim(),
                            );
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
                                      FocusScope.of(context).unfocus();
                                      if (controller.text.isEmpty &&
                                          !_cubit.refresh) {
                                        _cubit.refreshPosts(
                                          widget.pageRouter,
                                        );
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        GridView.builder(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .padding
                                                  .bottom),
                                          shrinkWrap: true,
                                          itemCount: _cubit.listData.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(left: 16.w),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: NFTItemWidget(
                                                  nftMarket:
                                                      _cubit.listData[index],
                                                  pageRouter: widget.pageRouter,
                                                ),
                                              ),
                                            );
                                          },
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 170.w / 231.h,
                                          ),
                                        ),
                                        if (state is ListNftLoadMore)
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .padding
                                                    .bottom,
                                              ),
                                              child: SizedBox(
                                                height: 16.h,
                                                width: 16.w,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 1.r,
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
                              return Expanded(
                                child: StaggeredGridView.countBuilder(
                                  shrinkWrap: true,
                                  mainAxisSpacing: 20.h,
                                  itemCount: 6,
                                  physics: const NeverScrollableScrollPhysics(),
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
                                      child: ErrorLoadNft(
                                        callback: () {
                                          _cubit.refreshPosts(
                                            widget.pageRouter,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  staggeredTileBuilder: (int index) {
                                    return const StaggeredTile.fit(1);
                                  },
                                ),
                              );
                            } else if (state is ListNftLoading) {
                              return Expanded(
                                child: StaggeredGridView.countBuilder(
                                  shrinkWrap: true,
                                  mainAxisSpacing: 20.h,
                                  itemCount: 6,
                                  physics: const NeverScrollableScrollPhysics(),
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
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
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
                            pageRouter: widget.pageRouter,
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
        widget.pageRouter,
      );
    });
  }
}

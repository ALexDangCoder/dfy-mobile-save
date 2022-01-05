import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/list_nft/bloc/list_nft_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:Dfy/presentation/nft_detail/ui/component/filter_bts.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ListNft extends StatefulWidget {
  const ListNft({Key? key, required this.marketType}) : super(key: key);
  final MarketType marketType;

  @override
  _ListNftState createState() => _ListNftState();
}

class _ListNftState extends State<ListNft> {
  late ListNftCubit _cubit;
  String title = '';
  TextEditingController controller = TextEditingController();
  late Timer _debounce;

  @override
  void initState() {
    super.initState();
    _debounce = Timer(const Duration(milliseconds: 500), () {});
    _cubit = ListNftCubit();
    _cubit.title.add(_cubit.getTitle(widget.marketType));
    _cubit.getCollectionFilter();
    _cubit.getListNft(status: _cubit.status(widget.marketType));
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
                  _cubit.selectCollection.clear();
                  _cubit.selectTypeNft.clear();
                  _cubit.selectStatus.clear();
                  showModalBottomSheet(
                    backgroundColor: Colors.black,
                    isScrollControlled: true,
                    context: context,
                    builder: (_) {
                      return FilterBts(
                        listNftCubit: _cubit,
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
                      BlocBuilder<ListNftCubit, ListNftState>(
                        bloc: _cubit,
                        builder: (context, state) {
                          if (state is ListNftSuccess) {
                            if (_cubit.listData.isNotEmpty) {
                              return Expanded(
                                child: StaggeredGridView.countBuilder(
                                  shrinkWrap: true,
                                  mainAxisSpacing: 20.h,
                                  itemCount: _cubit.listData.length,
                                  crossAxisCount: 2,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 16.w),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: NFTItemWidget(
                                          nftMarket: _cubit.listData[index],
                                        ),
                                      ),
                                    );
                                  },
                                  staggeredTileBuilder: (int index) =>
                                      const StaggeredTile.fit(1),
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
                          } else {
                            return SizedBox(
                              height: 100.h,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3.r,
                                  color: AppTheme.getInstance().whiteColor(),
                                ),
                              ),
                            );
                          }
                        },
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
                      _onSearchChanged(value);
                    },
                    cursorColor: Colors.white,
                    style: textNormal(
                      Colors.white,
                      16.sp,
                    ),
                    decoration: InputDecoration(
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
      _cubit.searchNft(query, _cubit.status(widget.marketType));
    });
  }
}

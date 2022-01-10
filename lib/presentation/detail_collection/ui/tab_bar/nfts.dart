import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/error_nft_collection_explore/error_load_nft.dart';
import 'package:Dfy/widgets/skeleton/skeleton_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NFTSCollection extends StatefulWidget {
  final DetailCollectionBloc detailCollectionBloc;

  const NFTSCollection({
    Key? key,
    required this.detailCollectionBloc,
  }) : super(key: key);

  @override
  _NFTSCollectionState createState() => _NFTSCollectionState();
}

class _NFTSCollectionState extends State<NFTSCollection> {
  final TextEditingController textSearch = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.detailCollectionBloc;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 343.w,
              height: 46.h,
              margin: EdgeInsets.only(top: 20.h),
              padding: EdgeInsets.only(right: 15.w, left: 15.w),
              decoration: BoxDecoration(
                color: AppTheme.getInstance().backgroundBTSColor(),
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: Image.asset(
                      ImageAssets.ic_search,
                    ),
                  ),
                  SizedBox(
                    width: 11.5.w,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 5.w),
                      child: TextFormField(
                        controller: textSearch,
                        onChanged: (value) {
                          bloc.textSearch.sink.add(value);
                          bloc.search(value);
                        },
                        cursorColor: AppTheme.getInstance().whiteColor(),
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          14,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: S.current.search,
                          hintStyle: textNormal(
                            AppTheme.getInstance().whiteWithOpacityFireZero(),
                            14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: bloc.textSearch,
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      return GestureDetector(
                        onTap: () {
                          bloc.textSearch.sink.add('');
                          textSearch.text = '';
                          bloc.search('');
                        },
                        child: snapshot.data?.isNotEmpty ?? false
                            ? Image.asset(
                                ImageAssets.ic_close,
                                width: 20.w,
                                height: 20.h,
                              )
                            : SizedBox(
                                height: 20.h,
                                width: 20.w,
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<int>(
            stream: bloc.statusNft,
            builder: (context, snapshot) {
              final statusNft = snapshot.data ?? 0;
              final list = bloc.listNft.value;
              if (statusNft == DetailCollectionBloc.SUCCESS) {
                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 21.w,
                    right: 21.w,
                    top: 20.h,
                    bottom: 20.h,
                  ),
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 26.w,
                  itemCount: list.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return NFTItemWidget(nftMarket: list[index]);
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                );
              } else if (statusNft == DetailCollectionBloc.FAILD) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    SizedBox(
                      width: 120.w,
                      height: 117.23.h,
                      child: Image.asset(
                        ImageAssets.img_search_empty,
                      ),
                    ),
                    spaceH16,
                    Text(
                      S.current.no_result_found,
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteWithOpacity(),
                        20,
                        FontWeight.bold,
                      ),
                    ),
                  ],
                );
              } else if (statusNft == DetailCollectionBloc.LOADING) {
                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 21.w,
                    right: 21.w,
                    top: 20.h,
                    bottom: 20.h,
                  ),
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 26.w,
                  itemCount: 4,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return const SkeletonNft();
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                );
              } else {
                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 21.w,
                    right: 21.w,
                    top: 20.h,
                    bottom: 20.h,
                  ),
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 26.w,
                  itemCount: 4,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return ErrorLoadNft(
                      callback: () {
                        widget.detailCollectionBloc.getListNft(
                          collectionId:
                              widget.detailCollectionBloc.collectionId,
                          name: widget.detailCollectionBloc.textSearch.value,
                          listMarketType:
                              widget.detailCollectionBloc.listFilter,
                        );
                      },
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

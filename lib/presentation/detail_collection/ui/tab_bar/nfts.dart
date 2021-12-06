import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/nft_item_by_category/nft_type_product.dart';
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
    final detailCollectionBloc = widget.detailCollectionBloc;
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
                          detailCollectionBloc.textSearch.sink.add(value);
                          //detailCollectionBloc.search();
                        },
                        cursorColor: AppTheme.getInstance().whiteColor(),
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          14.sp,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: S.current.search,
                          hintStyle: textNormal(
                            AppTheme.getInstance().whiteWithOpacityFireZero(),
                            14.sp,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: detailCollectionBloc.textSearch,
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      return GestureDetector(
                        onTap: () {
                          detailCollectionBloc.textSearch.sink.add('');
                          textSearch.text = '';
                          detailCollectionBloc.search();
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
          StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.data == null) {
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
                  itemCount: 10,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return const NftProduct(
                      nftName: 'Name of NFT',
                      price: 10000,
                      nftCategory: NFT_CATEGORY.SALE,
                      nftIsHard: NFT_IS_HARD.NON_HARD_NFT,
                      nftIsVidOrImg: NFT_IS_VID_OR_IMG.IMG_NFT,
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                );
              } else if (snapshot.hasError) {
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
                        20.sp,
                        FontWeight.bold,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    CircularProgressIndicator(
                      color: AppTheme.getInstance().whiteColor(),
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

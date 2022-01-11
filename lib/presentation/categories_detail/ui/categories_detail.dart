import 'package:Dfy/config/base/base_app_bar.dart';
import 'package:Dfy/config/base/base_custom_scroll_view.dart';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/model/market_place/explore_category_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/categories_detail/bloc/category_detail_cubit.dart';
import 'package:Dfy/presentation/categories_detail/bloc/category_detail_state.dart';
import 'package:Dfy/presentation/collection_list/ui/item_collection_load.dart';
import 'package:Dfy/presentation/collection_list/ui/item_error.dart';
import 'package:Dfy/presentation/detail_collection/ui/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/widget/base_collection.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/item/item_collection/item_colection.dart';
import 'package:Dfy/widgets/pull_to_refresh/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoriesDetail extends StatefulWidget {
  const CategoriesDetail({Key? key, required this.exploreCategory})
      : super(key: key);
  final ExploreCategory exploreCategory;

  @override
  _CategoriesDetailState createState() => _CategoriesDetailState();
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  CategoryDetailCubit cubit = CategoryDetailCubit();

  final ScrollController _listCollectionController = ScrollController();
  bool loading = true;

  void _onScroll() {
    if (_listCollectionController.hasClients || !loading) {
      final thresholdReached = _listCollectionController.position.pixels ==
          _listCollectionController.position.maxScrollExtent;
      if (thresholdReached) {
        cubit.getListCollection(widget.exploreCategory.id ?? '');
      }
    }
  }

  @override
  void initState() {
    _listCollectionController.addListener(_onScroll);
    cubit.getData(widget.exploreCategory.id ?? '');
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    cubit.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              await cubit.getListCollection(widget.exploreCategory.id ?? '');
            },
            child: BlocBuilder<CategoryDetailCubit, CategoryState>(
              bloc: cubit,
              builder: (BuildContext context, state) {
                if (state is LoadingCategoryState) {
                  return Container(
                    color: backgroundBottomSheetColor,
                    child: Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container (height:  145.h ,color:colorSkeletonLight),
                        const SizedBox (height : 12),
                        Container (
                          width: 200.w,
                          height:  25,
                          margin:const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: colorSkeletonLight,
                          ),
                        ),
                        const SizedBox (height : 6),
                        Container (
                          height:  18,
                          margin:const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: colorSkeletonLight,
                          ),
                        ),
                        const SizedBox (height : 32),
                        Expanded(
                          child: StaggeredGridView.countBuilder(
                            padding: const EdgeInsets.only(
                              left: 21,
                              right: 21,
                              top: 10,
                              bottom: 20,
                            ),
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 15,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const ItemCollectionLoad();
                            },
                            crossAxisCount: 2,
                            staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(1),
                          ),
                        )
                      ],
                    ),
                  );
                }
                if (state is LoadedCategoryState) {
                  return CustomScrollView(
                    physics: const ScrollPhysics(),
                    controller: _listCollectionController,
                    slivers: [
                      StreamBuilder<Category>(
                        stream: cubit.categoryStream,
                        builder: (context, snapshot) {
                          final data = snapshot.data;
                          return BaseAppBar(
                            image: data?.bannerCid ?? '',
                            title:
                            '${widget.exploreCategory.name} ${S.current
                                .categories}',
                            initHeight: 145.h,
                            leading: SizedBox(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: Image.asset(ImageAssets.img_back),
                                ),
                              ),
                            ),
                            actions: [
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 16,
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: 32,
                                    width: 32,
                                    child: Image.asset(ImageAssets.img_filter),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              color: backgroundBottomSheetColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12),
                                  Text(
                                    '${S.current.explore} ${widget
                                        .exploreCategory.name} ${S.current
                                        .categories}',
                                    style: textNormalCustom(
                                      AppTheme.getInstance().textThemeColor(),
                                      20,
                                      FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  StreamBuilder<Category>(
                                    stream: cubit.categoryStream,
                                    builder: (context, snapshot) {
                                      final data = snapshot.data;
                                      return Text(
                                        data?.description ?? '',
                                        style: textNormalCustom(
                                          AppTheme.getInstance()
                                              .textThemeColor()
                                              .withOpacity(0.7),
                                          14,
                                          FontWeight.w400,
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 32,
                              ),
                              constraints: BoxConstraints(
                                minHeight:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height - 145,
                              ),
                              color: backgroundBottomSheetColor,
                              child: StreamBuilder<List<CollectionDetailModel>>(
                                stream: cubit.listCollectionStream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data ?? [];
                                  return Column(
                                    children: [
                                      StaggeredGridView.countBuilder(
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 15,
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailCollection(
                                                        id: data[index].id ??
                                                            '',
                                                      ),
                                                ),
                                              );
                                            },
                                            child: ItemCollection(
                                              fixWidth: false,
                                              urlBackGround: ApiConstants
                                                  .BASE_URL_IMAGE +
                                                  (data[index].coverCid ?? ''),
                                              backgroundFit: BoxFit.cover,
                                              urlIcon: ApiConstants
                                                  .BASE_URL_IMAGE +
                                                  (data[index].avatarCid ?? ''),
                                              title: data[index].name ?? '',
                                              items: (data[index].totalNft ?? 0)
                                                  .toString(),
                                              owners:
                                              (data[index].nftOwnerCount ??
                                                  0)
                                                  .toString(),
                                              text: (data[index].description ??
                                                  '')
                                                  .stripHtmlIfNeeded(),
                                            ),
                                          );
                                        },
                                        crossAxisCount: 2,
                                        staggeredTileBuilder: (int index) =>
                                        const StaggeredTile.fit(1),
                                      ),
                                      StreamBuilder<bool>(
                                        stream: cubit.canLoadMoreStream,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data ?? true;
                                          if (data) {
                                            return SizedBox(
                                              height: 40,
                                              child: Center(
                                                child:
                                                CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                  color: AppTheme.getInstance()
                                                      .whiteColor(),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const SizedBox(height: 0);
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return  Container(
                    color: backgroundBottomSheetColor,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 54,
                            width: 54,
                            child: Image.asset(ImageAssets.err_load_category),
                          ),
                          const SizedBox (height : 24),
                          Flexible(
                            child: Text(
                              S.current.could_not_load_data,
                              style: textNormalCustom(
                                textErrorLoad,
                                13.sp,
                                FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox (height : 24),
                          InkWell(
                            onTap: () {
                              cubit.getData(widget.exploreCategory.id ?? '');
                            },
                            child: SizedBox(
                              height: 36,
                              width: 36,
                              child: Image.asset(ImageAssets.reload_category),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

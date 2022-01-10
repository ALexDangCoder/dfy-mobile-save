import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/collection_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collection_state.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:Dfy/presentation/collection_list/ui/item_error.dart';
import 'package:Dfy/presentation/detail_collection/ui/detail_collection.dart';
import 'package:Dfy/presentation/market_place/create_collection/bloc/bloc.dart';
import 'package:Dfy/presentation/market_place/create_collection/ui/create_collection_screen.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/form/from_search.dart';
import 'package:Dfy/widgets/item/item_collection/item_colection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../main.dart';
import 'filter.dart';
import 'filter_myacc.dart';
import 'item_collection_load.dart';

class CollectionList extends StatefulWidget {
  final String query;
  String? title;

  CollectionList({
    Key? key,
    required this.query,
    this.title,
  }) : super(key: key);

  @override
  _CollectionListState createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  late final CollectionBloc collectionBloc;
  late final TextEditingController searchCollection;
  bool isMyAcc = false;

  final ScrollController _listCollectionController = ScrollController();
  bool loading = true;

  void _onScroll() {
    if (_listCollectionController.hasClients || !loading) {
      final thresholdReached = _listCollectionController.position.pixels ==
          _listCollectionController.position.maxScrollExtent;
      if (thresholdReached) {
        collectionBloc.isCanLoadMore.add(true);
        collectionBloc.getListCollection(
          name: collectionBloc.textSearch.value,
          sortFilter: collectionBloc.sortFilter,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.title!.isNotEmpty) {
      widget.title = S.current.collection_search_result;
    } else {
      widget.title = S.current.collection_list;
    }
    collectionBloc = CollectionBloc();

    searchCollection = TextEditingController();
    searchCollection.text = widget.query;

    _listCollectionController.addListener(_onScroll);
    collectionBloc.getCollection(
      name: widget.query,
    );

    trustWalletChannel
        .setMethodCallHandler(collectionBloc.nativeMethodCallBackTrustWallet);
    collectionBloc.getListWallets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CreateCollectionScreen(
                  bloc: CreateCollectionBloc(),
                );
              },
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.getInstance().fillColor().withOpacity(0.3),
                spreadRadius: -5,
                blurRadius: 15,
                offset: const Offset(0, 10), // changes position of shadow
              ),
            ],
          ),
          child: Image.asset(
            ImageAssets.img_float_btn,
            fit: BoxFit.fill,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              height: 764.h,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.h),
                  topRight: Radius.circular(30.h),
                ),
              ),
              child: Column(
                children: [
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 16.w,
                          ),
                          width: 28.w,
                          height: 28.h,
                          child: Image.asset(
                            ImageAssets.ic_back,
                          ),
                        ),
                      ),
                      Text(
                        widget.title ?? S.current.collection_list,
                        style: textNormalCustom(
                          null,
                          20.sp,
                          FontWeight.w700,
                        ).copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!isMyAcc) {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Filter(
                                collectionBloc: collectionBloc,
                              ),
                            );
                          } else {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => FilterMyAcc(
                                collectionBloc: collectionBloc,
                              ),
                            );
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16.w),
                          width: 24.w,
                          height: 24.h,
                          child: Image.asset(ImageAssets.ic_filter),
                        ),
                      ),
                    ],
                  ),
                  spaceH20,
                  line,
                  spaceH12,
                  FormSearchBase(
                    onChangedFunction: collectionBloc.funOnSearch,
                    onTapFunction: collectionBloc.funOnTapSearch,
                    urlIcon: ImageAssets.ic_search,
                    hint: S.current.name_of_collection,
                    textSearchStream: collectionBloc.textSearch,
                    textSearch: searchCollection,
                  ),
                  spaceH10,
                  BlocBuilder<CollectionBloc, CollectionState>(
                    bloc: collectionBloc,
                    builder: (context, state) {
                      if (state is LoadingData) {
                        return Expanded(
                          child: StaggeredGridView.countBuilder(
                            padding: EdgeInsets.only(
                              left: 21.w,
                              right: 21.w,
                              top: 10.h,
                              bottom: 20.h,
                            ),
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 26.w,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return const ItemCollectionLoad();
                            },
                            crossAxisCount: 2,
                            staggeredTileBuilder: (int index) =>
                                const StaggeredTile.fit(1),
                          ),
                        );
                      } else if (state is LoadingDataFail) {
                        return Expanded(
                          child: StaggeredGridView.countBuilder(
                            padding: EdgeInsets.only(
                              left: 21.w,
                              right: 21.w,
                              top: 10.h,
                              bottom: 20.h,
                            ),
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 26.w,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return ItemCollectionError(cubit: collectionBloc);
                            },
                            crossAxisCount: 2,
                            staggeredTileBuilder: (int index) =>
                                const StaggeredTile.fit(1),
                          ),
                        );
                      } else if (state is LoadingDataSuccess) {
                        if (collectionBloc.list.value.length < 9) {
                          collectionBloc.isCanLoadMore.add(false);
                        }
                        return StreamBuilder(
                          stream: collectionBloc.list,
                          builder: (
                            context,
                            AsyncSnapshot<List<CollectionModel>> snapshot,
                          ) {
                            return Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  await collectionBloc.getCollection(
                                    name: collectionBloc.textSearch.value,
                                    sortFilter: collectionBloc.sortFilter,
                                  );
                                },
                                child: Expanded(
                                  child: SingleChildScrollView(
                                    controller: _listCollectionController,
                                    child: Column(
                                      children: [
                                        StaggeredGridView.countBuilder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.only(
                                            left: 21.w,
                                            right: 21.w,
                                            top: 10.h,
                                            bottom: 20.h,
                                          ),
                                          mainAxisSpacing: 20.h,
                                          crossAxisSpacing: 26.w,
                                          itemCount:
                                              collectionBloc.list.value.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return DetailCollection(
                                                        collectionAddress: collectionBloc
                                                                .list
                                                                .value[index]
                                                                .id ??
                                                            '',
                                                        walletAddress:
                                                            'alo alo alo',
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              child: ItemCollection(
                                                items:
                                                    '${snapshot.data?[index].totalNft ?? 0}',
                                                text: snapshot.data?[index]
                                                        .description
                                                        ?.parseHtml() ??
                                                    '',
                                                urlIcon: ApiConstants.URL_BASE +
                                                    (snapshot.data?[index]
                                                            .avatarCid ??
                                                        ''),
                                                owners:
                                                    '${snapshot.data?[index].nftOwnerCount ?? 0}',
                                                title: snapshot
                                                        .data?[index].name
                                                        ?.parseHtml() ??
                                                    '',
                                                urlBackGround:
                                                    ApiConstants.URL_BASE +
                                                        (snapshot.data?[index]
                                                                .coverCid ??
                                                            ''),
                                              ),
                                            );
                                          },
                                          crossAxisCount: 2,
                                          staggeredTileBuilder: (int index) =>
                                              const StaggeredTile.fit(1),
                                        ),
                                        StreamBuilder<bool>(
                                          stream: collectionBloc.isCanLoadMore,
                                          builder: (context, snapshot) {
                                            return snapshot.data ?? false
                                                ? Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                        16.w,
                                                      ),
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 3,
                                                        color: AppTheme
                                                                .getInstance()
                                                            .whiteColor(),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Expanded(
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
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

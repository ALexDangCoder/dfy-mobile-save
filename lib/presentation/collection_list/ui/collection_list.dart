import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collection_state.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:Dfy/presentation/collection_list/ui/item_error.dart';
import 'package:Dfy/presentation/detail_collection/ui/detail_collection.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/create_collection_screen.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_nft_screen.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/floating_button/ui/float_btn_add.dart';
import 'package:Dfy/widgets/form/from_search.dart';
import 'package:Dfy/widgets/item/item_collection/item_colection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'filter.dart';
import 'filter_myacc.dart';
import 'item_collection_load.dart';

class CollectionList extends StatefulWidget {
  final String? query;
  final String? title;
  final String? addressWallet;
  final PageRouter typeScreen;

  const CollectionList({
    Key? key,
    this.query,
    this.title,
    this.addressWallet,
    required this.typeScreen,
  }) : super(key: key);

  @override
  _CollectionListState createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  late final CollectionBloc collectionBloc;
  late final TextEditingController searchCollection;

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

  late String tittleScreen;

  @override
  void initState() {
    super.initState();
    if (widget.title?.isNotEmpty ?? false) {
      tittleScreen = widget.title ?? '';
    } else {
      tittleScreen = S.current.collection_list;
    }
    collectionBloc = CollectionBloc(widget.typeScreen);

    if (widget.addressWallet?.isNotEmpty ?? false) {
      collectionBloc.addressWallet = widget.addressWallet;
      collectionBloc.textAddressFilter.add(widget.addressWallet ?? '');
    } else {
      if (collectionBloc.typeScreen == PageRouter.MY_ACC) {
        collectionBloc.textAddressFilter
            .add(PrefsService.getCurrentBEWallet().toLowerCase());
        collectionBloc.addressWallet =
            PrefsService.getCurrentBEWallet().toLowerCase();
      }
    }
    searchCollection = TextEditingController();
    searchCollection.text = widget.query ?? '';
    collectionBloc.textSearch.sink.add(widget.query ?? '');
    _listCollectionController.addListener(_onScroll);
    collectionBloc.getCollection(
      name: widget.query?.trim(),
      sortFilter: collectionBloc.sortFilter,
    );
    collectionBloc.getListWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(
                name: AppRouter.create_nft,
              ),
              builder: (context) {
                return CreateNFTScreen(
                  cubit: CreateNftCubit(),
                );
              },
            ),
          );
        },
      ),
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
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
                      tittleScreen,
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
                        if (collectionBloc.typeScreen == PageRouter.MARKET) {
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
                    if (state is LoadingDataErorr) {
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
                    } else {
                      return StreamBuilder(
                        stream: collectionBloc.list,
                        builder: (
                          context,
                          AsyncSnapshot<List<CollectionMarketModel>> snapshot,
                        ) {
                          final list = snapshot.data ?? [];
                          return Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await collectionBloc.getCollection(
                                  name: collectionBloc.textSearch.value.trim(),
                                  sortFilter: collectionBloc.sortFilter,
                                );
                              },
                              child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                controller: _listCollectionController,
                                child: Column(
                                  children: [
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(
                                        left: 21.w,
                                        right: 21.w,
                                        top: 10.h,
                                        bottom: 16.h,
                                      ),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20.h,
                                        crossAxisSpacing: 26.w,
                                        childAspectRatio: 4 / 5,
                                      ),
                                      itemCount: state is LoadingDataSuccess
                                          ? list.length
                                          : 20,
                                      itemBuilder: (context, index) {
                                        if (state is LoadingDataSuccess) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return DetailCollection(
                                                      collectionAddress:
                                                          collectionBloc
                                                                  .list
                                                                  .value[index]
                                                                  .addressCollection ??
                                                              '',
                                                      typeScreen:
                                                          widget.typeScreen,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: ItemCollection(
                                              items:
                                                  '${list[index].totalNft ?? 0}',
                                              text: list[index]
                                                      .description
                                                      ?.parseHtml() ??
                                                  '',
                                              urlIcon: ApiConstants.URL_BASE +
                                                  (list[index].avatarCid ?? ''),
                                              owners:
                                                  '${list[index].nftOwnerCount ?? 0}',
                                              title: snapshot.data?[index].name
                                                      ?.parseHtml() ??
                                                  '',
                                              urlBackGround: ApiConstants
                                                      .URL_BASE +
                                                  (list[index].coverCid ?? ''),
                                            ),
                                          );
                                        } else if (state is LoadingDataFail) {
                                          return ItemCollectionError(
                                            cubit: collectionBloc,
                                          );
                                        } else {
                                          return const ItemCollectionLoad();
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      child: collectionBloc.resList.length != 20
                                          ? const SizedBox.shrink()
                                          : StreamBuilder<bool>(
                                              stream:
                                                  collectionBloc.isCanLoadMore,
                                              builder: (context, snapshot) {
                                                return snapshot.data ?? false
                                                    ? Center(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            bottom: 16.h,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
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
}

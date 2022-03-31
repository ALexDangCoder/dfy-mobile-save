import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/list_hard_nft/bloc/list_hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/list_hard_nft/bloc/list_hard_nft_state.dart';
import 'package:Dfy/presentation/market_place/list_hard_nft/ui/filter_hard_nft.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/error_nft_collection_explore/error_load_nft.dart';
import 'package:Dfy/widgets/form/from_search.dart';
import 'package:Dfy/widgets/skeleton/skeleton_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListHardNFt extends StatefulWidget {
  const ListHardNFt({Key? key}) : super(key: key);

  @override
  _ListHardNFtState createState() => _ListHardNFtState();
}

class _ListHardNFtState extends State<ListHardNFt> {
  late final ListHardNftBloc bloc;
  late final TextEditingController searchCollection;

  final ScrollController _listNFTController = ScrollController();
  bool loading = true;

  void _onScroll() {
    if (_listNFTController.hasClients || !loading) {
      final thresholdReached = _listNFTController.position.pixels ==
          _listNFTController.position.maxScrollExtent;
      if (thresholdReached) {
        bloc.isCanLoadMore.add(true);
        bloc.getListNftReload();
      }
    }
  }

  late String tittleScreen;

  @override
  void initState() {
    super.initState();
    bloc = ListHardNftBloc();
    searchCollection = TextEditingController();
    _listNFTController.addListener(_onScroll);
    bloc.getListNft();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            height: 812.h,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                      S.current.hard_nft_list,
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
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => FilterHardNFT(
                            bloc: bloc,
                          ),
                        );
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
                  onChangedFunction: bloc.funOnSearch,
                  onTapFunction: bloc.funOnTapSearch,
                  urlIcon: ImageAssets.ic_search,
                  hint: S.current.name_of_nft,
                  textSearchStream: bloc.textSearch,
                  textSearch: searchCollection,
                ),
                spaceH10,
                BlocBuilder<ListHardNftBloc, ListHardNftState>(
                  bloc: bloc,
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
                        stream: bloc.listNft,
                        builder: (
                          context,
                          AsyncSnapshot<List<NftMarket>> snapshot,
                        ) {
                          final list = snapshot.data ?? [];
                          return Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await bloc.getListNft();
                              },
                              child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                controller: _listNFTController,
                                child: Column(
                                  children: [
                                    GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: state is LoadingDataSuccess
                                          ? list.length
                                          : 20,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 170.w / 231.h,
                                      ),
                                      itemBuilder: (context, index) {
                                        if (state is LoadingDataSuccess) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(left: 16.w),
                                            child: NFTItemWidget(
                                              nftMarket: list[index],
                                            ),
                                          );
                                        } else if (state is LoadingDataErorr) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.w,
                                              bottom: 20.h,
                                              right: 16.w,
                                            ),
                                            child: ErrorLoadNft(
                                              callback: () {
                                                bloc.getListNft();
                                              },
                                            ),
                                          );
                                        } else {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.w,
                                              bottom: 20.h,
                                              right: 16.w,
                                            ),
                                            child: const SkeletonNft(),
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      child: bloc.listRes.length != 12
                                          ? const SizedBox.shrink()
                                          : StreamBuilder<bool>(
                                              stream: bloc.isCanLoadMore,
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

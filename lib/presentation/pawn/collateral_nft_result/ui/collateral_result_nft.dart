import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/presentation/pawn/collateral_nft_result/bloc/collateral_result_nft_bloc.dart';
import 'package:Dfy/presentation/pawn/collateral_nft_result/bloc/collateral_result_nft_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'filter_collateral_nft.dart';

class CollateralResultNFTScreen extends StatefulWidget {
  const CollateralResultNFTScreen({Key? key}) : super(key: key);

  @override
  _CollateralResultNFTScreenState createState() =>
      _CollateralResultNFTScreenState();
}

class _CollateralResultNFTScreenState extends State<CollateralResultNFTScreen> {
  late CollateralResultNFTBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CollateralResultNFTBloc();
    _bloc.refreshPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollateralResultNFTBloc, CollateralResultNFTState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is CollateralResultSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (_bloc.loadMoreRefresh) {}
            _bloc.showContent();
          } else {
            _bloc.mess = state.message ?? '';
            _bloc.showError();
          }
          _bloc.loadMoreLoading = false;
          if (_bloc.isRefresh) {
            _bloc.list.clear();
          }
          _bloc.list.addAll(state.listCollateral ?? []);
          _bloc.canLoadMoreMy =
              _bloc.list.length >= ApiConstants.DEFAULT_PAGE_SIZE;
        }
      },
      builder: (context, state) {
        final list = _bloc.list;
        return StateStreamLayout(
          retry: () {
            _bloc.getListCollateral();
          },
          textEmpty: _bloc.mess,
          error: AppException(S.current.error, _bloc.mess),
          stream: _bloc.stateStream,
          child: Scaffold(
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
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().bgBtsColor(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.h),
                      topRight: Radius.circular(30.h),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            S.current.collateral_result,
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
                                builder: (context) => FilterCollateralNFT(
                                  bloc: _bloc,
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
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          '${list.length} '
                          '${S.current.collateral_offers_match_your_search}',
                          style: textNormalCustom(
                            AppTheme.getInstance().pawnGray(),
                            16,
                            null,
                          ),
                        ),
                      ),
                      spaceH24,
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (_bloc.canLoadMore &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              _bloc.loadMorePosts();
                            }
                            return true;
                          },
                          child: RefreshIndicator(
                            onRefresh: _bloc.refreshPosts,
                            child: _bloc.list.isNotEmpty
                                ? GridView.builder(
                                    physics: const ClampingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 170.w / 231.h,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(left: 16.w),
                                        child: NFTItemWidget(
                                          nftMarket: list[index],
                                        ),
                                      );
                                    },
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Image(
                                          image: const AssetImage(
                                            ImageAssets.img_search_empty,
                                          ),
                                          height: 120.h,
                                          width: 120.w,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 17.7.h,
                                      ),
                                      Center(
                                        child: Text(
                                          S.current.no_result_found,
                                          style: textNormal(
                                            Colors.white54,
                                            20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

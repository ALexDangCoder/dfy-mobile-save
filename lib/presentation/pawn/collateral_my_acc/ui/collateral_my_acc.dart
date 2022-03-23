import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/ui/collateral_detail_my_acc.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_state.dart';
import 'package:Dfy/presentation/pawn/create_new_collateral/ui/create_new_collateral.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'filter_collateral_my_acc.dart';
import 'item_collateral_my_acc.dart';

class CollateralMyAcc extends StatefulWidget {
  const CollateralMyAcc({Key? key}) : super(key: key);

  @override
  _CollateralMyAccState createState() => _CollateralMyAccState();
}

class _CollateralMyAccState extends State<CollateralMyAcc> {
  late CollateralMyAccBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CollateralMyAccBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollateralMyAccBloc, CollateralMyAccState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is CollateralMyAccSuccess) {
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
            floatingActionButton: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateNewCollateral(),
                  ),
                ).whenComplete(
                  () => _bloc.refreshPosts(),
                );
              },
              child: Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: AppTheme.getInstance().colorFab(),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: 32.sp,
                  color: AppTheme.getInstance().whiteColor(),
                ),
              ),
            ),
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
                            S.current.collateral_list,
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
                                builder: (context) => FilterCollateralMyAcc(
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
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              child: list.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: list.length,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CollateralDetailMyAccScreen(
                                                    id: list[index].id.toString(),
                                                  ),
                                            ),
                                          );
                                        },
                                        child: ItemCollateralMyAcc(
                                          bloc: _bloc,
                                          index: index,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 60.h,
                                        ),
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

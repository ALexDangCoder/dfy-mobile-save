import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/add_collateral_list/bloc/add_collateral_bloc.dart';
import 'package:Dfy/presentation/pawn/add_collateral_list/bloc/add_collateral_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_add_collateral.dart';

class AddCollateral extends StatefulWidget {
  const AddCollateral({
    Key? key,
    required this.id,
    required this.estimate,
  }) : super(key: key);
  final String id;
  final String estimate;

  @override
  _AddCollateralState createState() => _AddCollateralState();
}

class _AddCollateralState extends State<AddCollateral> {
  late AddCollateralBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AddCollateralBloc(widget.id);
    bloc.estimate = widget.estimate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCollateralBloc, AddCollateralState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AddCollateralSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (bloc.loadMoreRefresh) {}
            bloc.showContent();
          } else {
            bloc.mess = state.message ?? '';
            bloc.showError();
          }
          bloc.loadMoreLoading = false;
          if (bloc.isRefresh) {
            bloc.list.clear();
          }
          bloc.list.addAll(state.list ?? []);
          bloc.canLoadMoreMy =
              bloc.list.length >= ApiConstants.DEFAULT_PAGE_SIZE;
        }
      },
      builder: (context, state) {
        return StateStreamLayout(
          retry: () {
            bloc.refreshPosts();
          },
          error: AppException(S.current.error, bloc.mess),
          stream: bloc.stateStream,
          textEmpty: bloc.mess,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.bottomCenter,
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
                        Container(
                          margin: EdgeInsets.only(
                            left: 16.w,
                          ),
                          width: 24.w,
                          height: 24.h,
                        ),
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            S.current.added_collateral,
                            style: textNormalCustom(
                              null,
                              20.sp,
                              FontWeight.w700,
                            ).copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 16.w),
                            width: 24.w,
                            height: 24.h,
                            child: Image.asset(ImageAssets.ic_close),
                          ),
                        ),
                      ],
                    ),
                    spaceH20,
                    line,
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (bloc.canLoadMore &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            bloc.loadMorePosts();
                          }
                          return true;
                        },
                        child: RefreshIndicator(
                          onRefresh: bloc.refreshPosts,
                          child: bloc.list.isNotEmpty
                              ? ListView.builder(
                                  itemCount: bloc.list.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                    top: 16.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    return ItemAddCollateral(
                                      obj: bloc.list[index],
                                      bloc: bloc,
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
        );
      },
    );
  }
}

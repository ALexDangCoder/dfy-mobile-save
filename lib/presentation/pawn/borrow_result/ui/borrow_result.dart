import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_result/bloc/borrow_result_cubit.dart';
import 'package:Dfy/presentation/pawn/borrow_result/ui/pawnshop_package_item.dart';
import 'package:Dfy/presentation/pawn/borrow_result/ui/personal_lending_item.dart';
import 'package:Dfy/presentation/pawn/personal_lending/ui/personal_lending_screen.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'filter_borrow.dart';

class BorrowResult extends StatefulWidget {
  final String? nameToken;
  final String? amount;

  const BorrowResult({
    Key? key,
    this.nameToken,
    this.amount,
  }) : super(key: key);

  @override
  _BorrowResultState createState() => _BorrowResultState();
}

class _BorrowResultState extends State<BorrowResult> {
  late BorrowResultCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BorrowResultCubit();
    cubit.getTokenInf();
    cubit.callApi(
      collateralSymbols:
          widget.nameToken != S.current.all ? widget.nameToken : '',
      collateralAmount: widget.amount,
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BorrowResultCubit, BorrowResultState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is BorrowPersonSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (cubit.refresh) {
              cubit.personalLending.clear();
            }
            cubit.showContent();
          } else {
            cubit.message = state.message ?? '';
            cubit.personalLending.clear();
            cubit.showError();
          }
          cubit.personalLending.addAll(state.personalLending ?? []);
        }
        if (state is BorrowPawnshopSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (cubit.refresh) {
              cubit.pawnshopPackage.clear();
            }
            cubit.showContent();
          } else {
            cubit.message = state.message ?? '';
            cubit.pawnshopPackage.clear();
            cubit.showError();
          }
          cubit.pawnshopPackage =
              cubit.pawnshopPackage + (state.pawnshopPackage ?? []);
          cubit.canLoadMoreList = (state.pawnshopPackage?.length ?? 0) >=
              ApiConstants.DEFAULT_PAGE_SIZE;
          cubit.loadMore = false;
          cubit.refresh = false;
        }
      },
      builder: (context, state) {
        return StateStreamLayout(
          retry: () {},
          textEmpty: cubit.message,
          error: AppException(S.current.error, cubit.message),
          stream: cubit.stateStream,
          child: BaseDesignScreen(
            onRightClick: () {
              showModalBottomSheet(
                backgroundColor: Colors.black,
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return FilterBorrow(
                    cubit: cubit,
                  );
                },
              );
            },
            isImage: true,
            title: 'Borrow result',
            text: ImageAssets.ic_filter,
            child: SizedBox(
              height: 699.h,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (cubit.canLoadMoreList &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    cubit.loadMorePosts();
                  }
                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: () async {
                    await cubit.refreshPosts();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spaceH24,
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'PERSONAL LENDING',
                                style: textNormalCustom(
                                  purple,
                                  20,
                                  FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PersonalLendingScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 32.h,
                                  decoration: const BoxDecoration(
                                    color: borderItemColors,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image(
                                    height: 32.h,
                                    width: 32.w,
                                    image: const AssetImage(
                                      ImageAssets.img_push,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        spaceH16,
                        SizedBox(
                          height: cubit.personalLending.isNotEmpty ? 246.h : 0,
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 16.w),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.personalLending.length > 6
                                ? 6
                                : cubit.personalLending.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  PersonalLendingItem(
                                    personalLending:
                                        cubit.personalLending[index],
                                  ),
                                  spaceW20,
                                ],
                              );
                            },
                          ),
                        ),
                        spaceH32,
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: Text(
                            'PAWNSHOP PACKAGE',
                            style: textNormalCustom(
                              purple,
                              20,
                              FontWeight.w400,
                            ),
                          ),
                        ),
                        spaceH16,
                        SizedBox(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            shrinkWrap: true,
                            itemCount: cubit.pawnshopPackage.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  PawnshopPackageItem(
                                    pawnshopPackage:
                                        cubit.pawnshopPackage[index],
                                  ),
                                  spaceH20,
                                ],
                              );
                            },
                          ),
                        ),
                        if (state is BorrowResultLoadmore)
                          Center(
                            child: SizedBox(
                              height: 16.h,
                              width: 16.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.r,
                                color: AppTheme.getInstance().whiteColor(),
                              ),
                            ),
                          ),
                        spaceH16,
                      ],
                    ),
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

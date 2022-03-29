import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/presentation/pawn/repayment_history_detail/bloc/repayment_history_detail_bloc.dart';
import 'package:Dfy/presentation/pawn/repayment_history_detail/bloc/repayment_history_detail_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_repayment.dart';

class RepaymentHistoryDetail extends StatefulWidget {
  const RepaymentHistoryDetail({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  _RepaymentHistoryDetailState createState() => _RepaymentHistoryDetailState();
}

class _RepaymentHistoryDetailState extends State<RepaymentHistoryDetail> {
  late RepaymentHistoryDetailBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = RepaymentHistoryDetailBloc(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RepaymentHistoryDetailBloc,
        RepaymentHistoryDetailState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is RepaymentHistoryDetailSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (bloc.loadMoreRefresh) {}
            bloc.showContent();
          } else {
            bloc.mess = state.message ?? '';
            bloc.showError();
          }
          // bloc.loadMoreLoading = false;
          //  if (bloc.isRefresh) {
          //    bloc.list.clear();
          //  }
          bloc.list.addAll(state.list ?? []);
          // bloc.canLoadMoreMy =
          //     bloc.list.length >= ApiConstants.DEFAULT_PAGE_SIZE;
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
                            S.current.repayment_history_detail,
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
                        // onNotification: (ScrollNotification scrollInfo) {
                        // if (bloc.canLoadMore &&
                        //     scrollInfo.metrics.pixels ==
                        //         scrollInfo.metrics.maxScrollExtent) {
                        //   bloc.loadMorePosts();
                        // }
                        // return true;
                        // },
                        child: RefreshIndicator(
                          onRefresh: bloc.refreshPosts,
                          child: bloc.list.isNotEmpty
                              ? Column(
                                  children: [
                                    spaceH12,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: bloc.list.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            ItemRepaymentHistory(
                                          obj: bloc.list[index],
                                          bloc: bloc,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          line,
                                          spaceH20,
                                          Text(
                                            S.current.total,
                                            style: textNormalCustom(
                                              null,
                                              20,
                                              FontWeight.w600,
                                            ),
                                          ),
                                          spaceH16,
                                          richText(
                                            title: '${S.current.penalty}:',
                                            value:
                                                '${formatPrice.format(bloc.obj.totalPenalty ?? 0)} ${bloc.obj.symbolPenalty}',
                                            isIcon: true,
                                            url: ImageAssets.getUrlToken(
                                              bloc.obj.symbolPenalty ?? '',
                                            ),
                                          ),
                                          spaceH16,
                                          richText(
                                            title: '${S.current.interest}:',
                                            value:
                                                '${formatPrice.format(bloc.obj.totalInterest ?? 0)} ${bloc.obj.symbolInterest}',
                                            isIcon: true,
                                            url: ImageAssets.getUrlToken(
                                              bloc.obj.symbolInterest ?? '',
                                            ),
                                          ),
                                          spaceH16,
                                          richText(
                                            title: '${S.current.loan}:',
                                            value:
                                                '${formatPrice.format(bloc.obj.totalLoan ?? 0)} ${bloc.obj.symbolLoan}',
                                            isIcon: true,
                                            url: ImageAssets.getUrlToken(
                                              bloc.obj.symbolLoan ?? '',
                                            ),
                                          ),
                                          spaceH70,
                                        ],
                                      ),
                                    ),
                                  ],
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

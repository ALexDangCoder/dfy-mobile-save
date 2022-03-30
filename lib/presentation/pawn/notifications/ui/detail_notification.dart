import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/notifications/cubit/notifications_cubit.dart';
import 'package:Dfy/presentation/pawn/notifications/ui/noti_item.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailNotification extends StatefulWidget {
  const DetailNotification(
      {Key? key, required this.indexTypeNoti, required this.title})
      : super(key: key);

  final int indexTypeNoti;
  final String title;

  @override
  _DetailNotificationState createState() => _DetailNotificationState();
}

class _DetailNotificationState extends State<DetailNotification> {
  late NotificationsCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = NotificationsCubit();
    cubit.getNotiDetail(notiType: widget.indexTypeNoti, isRead: -1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is NotificationsDetailSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (cubit.refresh) {
              cubit.listNotificationDetail.clear();
            }
            cubit.showContent();
          } else {
            cubit.message = state.message ?? '';
            cubit.listNotificationDetail.clear();
            cubit.showError();
          }
          cubit.listNotificationDetail =
              cubit.listNotificationDetail + (state.list ?? []);
          cubit.canLoadMoreList =
              (state.list?.length ?? 0) >= ApiConstants.DEFAULT_PAGE_SIZE;
          cubit.loadMore = false;
          cubit.refresh = false;
        }
      },
      builder: (context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, ''),
          retry: () {
            cubit.refreshPosts(notiType: widget.indexTypeNoti, isRead: -1);
          },
          textEmpty: '',
          child: BaseDesignScreen(
            title: widget.title,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (cubit.canLoadMoreList &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  cubit.loadMorePosts(
                      notiType: widget.indexTypeNoti, isRead: -1);
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  await cubit.refreshPosts(
                      notiType: widget.indexTypeNoti, isRead: -1);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: (state is NotificationsDetailSuccess ||
                          state is NotificationsLoadMore)
                      ? StreamBuilder<String>(
                          stream: cubit.delete,
                          builder: (context, snapshot) {
                            return SizedBox(
                              child: cubit.listNotificationDetail.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          cubit.listNotificationDetail.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NotiItem(
                                              cubit: cubit,
                                              notificationDetail:
                                                  cubit.listNotificationDetail[
                                                      index],
                                              index: index,
                                            ),
                                            divider,
                                          ],
                                        );
                                      },
                                    )
                                  : SizedBox(
                                      child: Column(
                                        children: [
                                          spaceH152,
                                          Image.asset(
                                            ImageAssets.img_no_noti,
                                            width: 203,
                                            height: 176,
                                          ),
                                          spaceH13,
                                          Text(
                                            'No notification!',
                                            style: textNormalCustom(
                                              Colors.white,
                                              16,
                                              FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                              /// handle no response
                            );
                          })
                      : const SizedBox(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

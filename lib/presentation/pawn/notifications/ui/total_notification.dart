import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/notifications/cubit/notifications_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'detail_notification.dart';

class TotalNotification extends StatefulWidget {
  const TotalNotification({Key? key}) : super(key: key);

  @override
  _TotalNotificationState createState() => _TotalNotificationState();
}

class _TotalNotificationState extends State<TotalNotification> {
  late NotificationsCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = NotificationsCubit();
    cubit.getNoti(
      notiType: 0,
      isRead: -1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cubit,
      builder: (BuildContext context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, ''),
          retry: () {},
          textEmpty: '',
          child: BaseDesignScreen(
            title: 'Notifications',
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemNotification(
                    ImageAssets.ic_noti_all,
                    'All',
                    cubit.listNotification.isNotEmpty
                        ? (cubit.listNotification[0].total ?? 0)
                        : 0,
                    0,
                  ),
                  divider,
                  itemNotification(
                    ImageAssets.ic_noti_hot,
                    'Hot',
                    cubit.listNotification.isNotEmpty
                        ? (cubit.listNotification[1].total ?? 0)
                        : 0,
                    1,
                  ),
                  divider,
                  itemNotification(
                    ImageAssets.ic_noti_activities,
                    'Activities',
                    cubit.listNotification.isNotEmpty
                        ? (cubit.listNotification[2].total ?? 0)
                        : 0,
                    2,
                  ),
                  divider,
                  itemNotification(
                    ImageAssets.ic_noti_new_system,
                    'New system',
                    cubit.listNotification.isNotEmpty
                        ? (cubit.listNotification[3].total ?? 0)
                        : 0,
                    3,
                  ),
                  divider,
                  itemNotification(
                    ImageAssets.ic_noti_warning,
                    'Warning',
                    cubit.listNotification.isNotEmpty
                        ? (cubit.listNotification[4].total ?? 0)
                        : 0,
                    4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemNotification(String image, String title, int count, int type) {
    return InkWell(
      onTap: () {
        goTo(
          context,
          DetailNotification(
            title: title,
            indexTypeNoti: type,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 19.h,
          bottom: 18.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                sizedSvgImage(w: 28, h: 28, image: image),
                spaceW16,
                Text(
                  title,
                  style: textNormalCustom(
                    Colors.white,
                    16,
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                if (count > 0)
                  Container(
                    padding: EdgeInsets.only(
                      left: 8.w,
                      right: 8.w,
                    ),
                    decoration: BoxDecoration(
                      color: failTransactionColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    child: Text(
                      count > 99 ? '99+' : count.toString(),
                      style: textNormalCustom(
                        Colors.white,
                        16,
                        FontWeight.w600,
                      ),
                    ),
                  ),
                spaceW12,
                Image.asset(
                  ImageAssets.ic_line_right,
                  height: 24.h,
                  width: 24.w,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/pawn/notification.dart';
import 'package:Dfy/presentation/pawn/notifications/cubit/notifications_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotiItem extends StatefulWidget {
  const NotiItem(
      {Key? key,
      required this.cubit,
      required this.notificationDetail,
      required this.index})
      : super(key: key);

  final NotificationsCubit cubit;
  final NotificationDetail notificationDetail;
  final int index;

  @override
  _NotiItemState createState() => _NotiItemState();
}

class _NotiItemState extends State<NotiItem> {
  bool _customTileExpanded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 3,
            onPressed: (context) {
              if (widget.notificationDetail.isRead == false) {
                widget.cubit.updateNoti(widget.notificationDetail.id);
                widget.notificationDetail.isRead = true;
                setState(() {});
              }
            },
            spacing: 6.r,
            backgroundColor: Colors.white.withOpacity(0.2),
            foregroundColor: Colors.white,
            label: 'Mark as read',
          ),
          SlidableAction(
            flex: 2,
            spacing: 4.r,
            onPressed: (context) {
              widget.cubit.listNotificationDetail.removeAt(widget.index);
              widget.cubit.delete.add('delete');
            },
            backgroundColor: redMarketColor.withOpacity(0.2),
            foregroundColor: redMarketColor,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (widget.notificationDetail.isRead == false) {
            widget.cubit.updateNoti(widget.notificationDetail.id);
            widget.notificationDetail.isRead = true;
            setState(() {});
          }
          setState(() {
            _customTileExpanded = !_customTileExpanded;
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 8.h,
                  width: 8.w,
                  decoration: BoxDecoration(
                    color: !(widget.notificationDetail.isRead ?? false)
                        ? successTransactionColor
                        : grey3,
                    shape: BoxShape.circle,
                  ),
                ),
                spaceW4,
                Text(
                  getTitle(
                    widget.notificationDetail.txType ?? 0,
                    widget.notificationDetail.userType ?? 0,
                  ),
                  style: textNormalCustom(
                    Colors.white,
                    16,
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
            spaceH8,
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tellus gravida duis non, id integer. Aliquam adipiscing quisque faucibus amet volutpat rutrum. Cum maecenas molestie sed dolor fringilla. Volutpat nisl aliquet mauris nisi id rhoncus id eleifend suscipit. Ultrices auctor sit amet molestie faucibus massa at ullamcorper. Auctor morbi hac eget facilisi pellentesque orci in vel elementum.',
                    style: textNormalCustom(
                      Colors.white.withOpacity(0.7),
                      14,
                      FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: _customTileExpanded == true ? 2 : 100,
                  ),
                  spaceH10,
                  Row(
                    children: [
                      Text(
                        formatDateTime3.format(
                          DateTime.fromMillisecondsSinceEpoch(
                            widget.notificationDetail.createAt ?? 0,
                          ),
                        ),
                        style: textNormalCustom(
                          Colors.white.withOpacity(0.5),
                          14,
                          FontWeight.w400,
                        ),
                      ),
                      spaceW10,
                      Icon(
                        _customTileExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        size: 24.sp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTitle(int txType, int userType) {
    switch (txType) {
      case 1:
        return 'Create collateral successfully';
      case 2:
        return 'Submit collateral to pawnshop';
      case 3:
        return 'Submit collateral to personal lender';
      case 4:
        return 'Withdraw collateral';
      case 5:
        if (userType == 1) {
          return 'Receive a loan offer';
        } else {
          return 'Send loan offer';
        }
      case 6:
        return 'Create loan package successfully';
      case 7:
        return 'Cancel loan package';
      case 8:
        return 'Reopen loan package';
      case 9:
        return 'New contract auto loan package';
      case 10:
        return 'New contract accept offer';
      case 11:
        return 'New contract semi auto';
      case 12:
        return 'Reject collateral';
      case 13:
        return 'Reject offer';
      case 14:
        return 'Receive new payment request';
      case 15:
        return 'Payment part of a period debt';
      case 16:
        return 'Payment full a period debt';
      case 17:
        return 'Warning over due term';
      case 18:
        return 'Warning default to max late';
      case 19:
        return 'Warning ltv liquidate threshold';
      case 20:
        return 'Add more collateral';
      case 21:
        return 'Default contract';
      case 22:
        return 'Complete contract';
      case 23:
        return 'Borrower review contract';
      case 24:
        return 'Lender review contract';
      default:
        return '';
    }
  }
}
